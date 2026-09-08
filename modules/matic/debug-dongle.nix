# Matic debug dongle: CP2105 serial bridge plus the bot's USB ethernet gadget
# (0525:a4a1), both behind the dongle's hub.
#
# 60-matic-debug-conn.rules is a verbatim copy of
# rust/debug_conn_v3/60-matic-debug-conn.rules in the matic repo. Eventually the
# matic repo should be a flake input and this file referenced from it. It grants
# the seated user access to the serial and gpio devices (no dialout group or
# sudo needed) and marks the NIC link-local-only for NetworkManager and networkd.
#
# 62-matic-debug-dongle-name.rules is ours and names the bot's NIC
# `matic_dbg<ifindex>`, which the profile and helper below rely on.
{ pkgs, ... }:
let
  ifaceGlob = "matic_dbg*";
  # FujiDebugConnector::IPV6_ADDR in rust/debug_conn_v3; identical on every bot.
  botAddr = "fe80::1cab:79ff:feab:e35c";
  # Not services.udev.extraRules: that concatenates into 99-local.rules, and the
  # NAME= rules must sort before 80-net-setup-link.rules.
  # Destination names are spelled out: the store paths carry a hash prefix, and
  # udev sorts rules files by name, so the prefix would push these after 70/80.
  udevRules = pkgs.runCommand "matic-debug-dongle-udev-rules" { } ''
    install -Dm444 ${./60-matic-debug-conn.rules} $out/etc/udev/rules.d/60-matic-debug-conn.rules
    install -Dm444 ${./62-matic-debug-dongle-name.rules} $out/etc/udev/rules.d/62-matic-debug-dongle-name.rules
  '';
in
{
  services.udev.packages = [ udevRules ];

  # Link-local on both families, matching what the company's udev property
  # makes NetworkManager do by default for this interface.
  networking.networkmanager.ensureProfiles.profiles.matic-debug = {
    connection = {
      id = "matic-debug";
      type = "ethernet";
    };
    match.interface-name = ifaceGlob;
    ipv4.method = "link-local";
    ipv6.method = "link-local";
  };

  environment.systemPackages = [
    # Print the bot's link-local address scoped to its debug interface, e.g.
    #   ssh root@$(matic-debug-ip)
    # With several bots attached, pass the interface name to pick one.
    (pkgs.writeShellScriptBin "matic-debug-ip" ''
      bot="${botAddr}"
      shopt -s nullglob
      ifaces=(/sys/class/net/${ifaceGlob})

      if [ "''${#ifaces[@]}" -eq 0 ]; then
        # The ethernet gadget is the bot's; the CP2105 is the dongle's. Tell
        # "no dongle" apart from "dongle present, bot off".
        for d in /sys/bus/usb/devices/*; do
          if [ "$(cat "$d/idVendor" 2>/dev/null)" = 10c4 ] && [ "$(cat "$d/idProduct" 2>/dev/null)" = ea70 ]; then
            echo "Debug dongle present but no bot ethernet interface (bot off?)" >&2
            exit 1
          fi
        done
        echo "No debug dongle connected" >&2
        exit 1
      fi

      if [ "$#" -ge 1 ]; then
        iface="$1"
      elif [ "''${#ifaces[@]}" -eq 1 ]; then
        iface="$(basename "''${ifaces[0]}")"
      else
        echo "Several bots attached; pass one of:" >&2
        for i in "''${ifaces[@]}"; do basename "$i" >&2; done
        exit 1
      fi

      if ! ${pkgs.iputils}/bin/ping -6 -c1 -W1 "$bot%$iface" >/dev/null 2>&1; then
        echo "Bot not answering at $bot%$iface" >&2
        exit 1
      fi
      echo "$bot%$iface"
    '')
  ];
}
