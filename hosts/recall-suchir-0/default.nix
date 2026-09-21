{ inputs, ... }:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    ../../modules/home-manager/default.nix
    ../../modules/darwin/user.nix
    ../../modules/determinate-nix.nix
    ../../modules/environment.nix
  ];

  time.timeZone = "America/Los_Angeles";

  networking.hostName = "recall-suchir-0";
  networking.computerName = "recall-suchir-0";

  # GUI apps that nixpkgs does not build for Darwin (Chrome, Docker Desktop,
  # ...) are easiest to get via the homebrew module. Requires Homebrew to be
  # installed already, so it is left off until then.
  # homebrew = {
  #   enable = true;
  #   casks = [ "google-chrome" ];
  # };

  system.stateVersion = 7;
}
