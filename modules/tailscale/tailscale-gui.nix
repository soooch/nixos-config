# Vendored from nix-darwin PR #1683 ("programs/tailscale-gui: init module",
# head e84d3cb) until it is merged:
# https://github.com/nix-darwin/nix-darwin/pull/1683
#
# The standalone Tailscale app compares its bundle path against the literal
# "/Applications/Tailscale.app" at startup and refuses to run anywhere else,
# so it can't go through environment.systemPackages (which lands in
# /Applications/Nix Apps). Once the PR lands, delete this file and the import
# of it; `programs.tailscale-gui.enable = true` will then come from nix-darwin.
{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.programs.tailscale-gui;
in
{
  options = {
    programs.tailscale-gui = {
      enable = lib.mkEnableOption "the Tailscale GUI application";
      package = lib.mkPackageOption pkgs "Tailscale GUI" {
        default = [ "tailscale-gui" ];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    system.activationScripts.applications.text = lib.mkAfter ''
      install -o root -g wheel -m0555 -d "/Applications/Tailscale.app"
      rsyncFlags=(
        --checksum
        --copy-unsafe-links
        --archive
        --delete
        --chmod=-w
        --no-group
        --no-owner
      )
      ${lib.getExe pkgs.rsync} "''${rsyncFlags[@]}" \
        ${cfg.package}/Applications/Tailscale.app/ /Applications/Tailscale.app
    '';
  };
}
