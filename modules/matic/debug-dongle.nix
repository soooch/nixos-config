{
  pkgs,
  ...
}:
{
  networking.networkmanager.ensureProfiles.profiles = {
    matic-debug = {
      connection = {
        id = "matic-debug";
        type = "ethernet";
        interface-name = "enp14s0u3u2";
      };
      ipv4 = {
        method = "disabled";
      };
      ipv6 = {
        method = "link-local";
      };
    };
  };
  environment.systemPackages =
    let
      matic-debug-ip = pkgs.writeShellScriptBin "matic-debug-ip" ''
        iface="enp14s0u3u2"
        ${pkgs.iputils}/bin/ping -6 -c1 ff02::1%$iface >/dev/null 2>&1
        addr=$(${pkgs.iproute2}/bin/ip -6 neigh show dev $iface | ${pkgs.gawk}/bin/awk '{print $1}' | head -1)
        if [ -z "$addr" ]; then
          echo "No device found on $iface" >&2
          exit 1
        fi
        echo "$addr%$iface"
      '';
    in
    [ matic-debug-ip ];
}
