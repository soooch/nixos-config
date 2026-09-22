{ inputs, ... }:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    ../../modules/home-manager/default.nix
    ../../modules/darwin/user.nix
    ../../modules/determinate-nix.nix
    ../../modules/environment.nix
    ../../modules/tailscale/nix-darwin.nix
  ];

  time.timeZone = "America/Los_Angeles";

  networking.hostName = "recall-suchir-0";
  networking.computerName = "recall-suchir-0";

  system.stateVersion = 7;
}
