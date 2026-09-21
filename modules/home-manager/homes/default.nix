{ ... }:
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
