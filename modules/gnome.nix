{pkgs, ...}: {
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # List services that you want to enable:

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = [pkgs.gnome-console];
  environment.systemPackages = let
    vte-osc52-patch = pkgs.fetchpatch {
      name = "0002-Add-support-for-OSC52-writes.patch";
      url = "https://github.com/soooch/vte/commit/fcdd1657b10de0f2af31d849a57a9f568c983e86.patch";
      hash = "sha256-goCS+hgqDZO81L+AAllydXUifzAclgRbf66qTXlzwWI=";
    };
    vte-gtk4-osc52 = pkgs.vte-gtk4.overrideAttrs (final: prev: {
      patches = prev.patches ++ [vte-osc52-patch];
    });
    gnome-console-osc52 = pkgs.gnome-console.override {vte-gtk4 = vte-gtk4-osc52;};
  in [gnome-console-osc52];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
