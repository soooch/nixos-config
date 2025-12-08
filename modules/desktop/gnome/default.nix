{ pkgs, ... }:
{
  # https://wiki.nixos.org/wiki/Wayland#Electron_and_Chromium
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = [ pkgs.gnome-console ];
  environment.systemPackages =
    let
      vte-osc52-patch = ./0001-terminal-Add-support-for-OSC52-writes.patch;
      vte-gtk4-osc52 = pkgs.vte-gtk4.overrideAttrs (
        final: prev: {
          patches = prev.patches ++ [ vte-osc52-patch ];
        }
      );
      gnome-console-osc52 = pkgs.gnome-console.override { vte-gtk4 = vte-gtk4-osc52; };
    in
    [ gnome-console-osc52 ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
