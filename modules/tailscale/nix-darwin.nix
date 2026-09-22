{ pkgs, ... }:
{
  # Tailscale's macOS app rather than services.tailscale: we want the GUI.
  environment.systemPackages = [ pkgs.tailscale-gui ];
}
