{ ... }:
{
  # Tailscale's macOS app rather than services.tailscale: we want the GUI.
  imports = [ ./tailscale-gui.nix ];
  programs.tailscale-gui.enable = true;
}
