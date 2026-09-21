{ lib, pkgs, ... }:
{
  # Packages in the system profile. To search: nix search nixpkgs wget
  environment.systemPackages =
    with pkgs;
    lib.optionals stdenv.isLinux [ lm_sensors ]
    ++ [
      nnn
      ripgrep
      wget
    ];

  # Login shells chsh will accept (/etc/shells).
  environment.shells = with pkgs; [
    nushell
    fish
  ];

  # The system fish module owns /etc/fish/*, which is how a fish login shell
  # gets the system environment (PATH with /run/current-system/sw/bin and
  # friends). home-manager's fish module owns ~/.config/fish/* on top of it.
  programs.fish.enable = true;
}
