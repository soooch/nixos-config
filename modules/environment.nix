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
}
