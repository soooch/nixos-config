{
  description = "Suchir's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty.url = "github:ghostty-org/ghostty";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    rust-overlay,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      formatter = pkgs.alejandra;
    })
    // {
      nixosConfigurations = let
        commonModules = [{nixpkgs.overlays = [rust-overlay.overlays.default];}];
        defSystem = {
          system,
          vars,
          hostModule,
        }:
          nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [hostModule] ++ commonModules;
            specialArgs = {inherit inputs vars;};
          };
      in {
        lovelace = defSystem {
          system = "x86_64-linux";
          vars = {
            username = "soooch";
            fullname = "Suchir Kavi";
            email = "suchirkavi@gmail.com";
          };
          hostModule = ./hosts/lovelace;
        };
        matic1 = defSystem {
          system = "x86_64-linux";
          vars = {
            username = "suchir";
            fullname = "Suchir Kavi";
            email = "suchirkavi@gmail.com";
          };
          hostModule = ./hosts/matic1;
        };
      };
    };
}
