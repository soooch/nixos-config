{ pkgs, ... }:
{
  imports = [
    ../modules/core
    ../modules/gui
    ../modules/tui
  ];

  # home.username and home.homeDirectory come from users.users.<name> on
  # the system side (NixOS and nix-darwin both), so they are not set here.
  home = {
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.11";
  };

  # Copy app bundles into ~/Applications/Home Manager Apps instead of
  # symlinking them: Spotlight and Launchpad do not index symlinks into the
  # store. This is home-manager's default from stateVersion 25.11 on; ours is
  # older. Both options assert they are on Darwin, hence the gate.
  targets.darwin.linkApps.enable = false;
  targets.darwin.copyApps.enable = pkgs.stdenv.isDarwin;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
