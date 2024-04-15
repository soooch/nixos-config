{
  pkgs,
  config,
  nixvim,
  ...
}: {
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  programs = {
    nixvim = {
      enable = true;
    };
  };
}
