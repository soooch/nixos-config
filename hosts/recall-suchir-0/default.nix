{ inputs, vars, ... }:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    ../../modules/home-manager/default.nix
    ../../modules/darwin/user.nix
    # `sudo darwin-rebuild switch` fetches git+ssh inputs as root.
    ../../modules/root-github-ssh.nix
    ../../modules/determinate-nix.nix
    ../../modules/environment.nix
    ../../modules/tailscale/nix-darwin.nix
  ];

  home-manager.users.${vars.username}.imports = [
    ../../modules/home-manager/modules/recall/aws.nix
  ];

  time.timeZone = "America/Los_Angeles";

  networking.hostName = "recall-suchir-0";
  networking.computerName = "recall-suchir-0";

  system.stateVersion = 7;
}
