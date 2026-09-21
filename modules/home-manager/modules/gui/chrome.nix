{ pkgs, ... }:
{
  programs = {
    google-chrome = {
      # nixpkgs only packages Chrome for Linux; use the homebrew cask on Darwin.
      enable = pkgs.stdenv.isLinux;

      # extensions not supported for proprietary google-chrome
      # extensions = [
      # {id = "";}  // extension id, query from chrome web store
      # ];
    };
  };
}
