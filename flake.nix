{
  description = "Suchir's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
    flake-utils.url = "github:numtide/flake-utils";
    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
    ghostty.url = "github:ghostty-org/ghostty";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      flake-utils,
      rust-overlay,
      ...
    }@inputs:
    let
      commonModules = [
        {
          nixpkgs.overlays = [ rust-overlay.overlays.default ];
          nixpkgs.config.allowUnfree = true;
        }
      ];
      defSystem =
        {
          system,
          vars,
          hostModule,
        }:
        let
          mkSystem =
            if (nixpkgs.lib.systems.elaborate system).isDarwin then
              nix-darwin.lib.darwinSystem
            else
              nixpkgs.lib.nixosSystem;
        in
        mkSystem {
          modules = [
            hostModule
            { nixpkgs.hostPlatform = system; }
          ]
          ++ commonModules;
          specialArgs = { inherit inputs vars; };
        };
    in
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        formatter = pkgs.nixfmt-tree;
      }
    )
    // {
      darwinConfigurations = {
        recall-suchir-0 = defSystem {
          system = "aarch64-darwin";
          vars = {
            username = "suchir";
            fullname = "Suchir Kavi";
            email = "suchirkavi@gmail.com";
          };
          hostModule = ./hosts/recall-suchir-0;
        };
      };

      nixosConfigurations = {
        lovelace = defSystem {
          system = "x86_64-linux";
          vars = {
            username = "soooch";
            fullname = "Suchir Kavi";
            email = "suchirkavi@gmail.com";
          };
          hostModule = ./hosts/lovelace;
        };
        matic-suchir-1 = defSystem {
          system = "x86_64-linux";
          vars = {
            username = "suchir";
            fullname = "Suchir Kavi";
            email = "suchirkavi@gmail.com";
          };
          hostModule = ./hosts/matic-suchir-1;
        };
        matic-suchir-0 = defSystem {
          system = "x86_64-linux";
          vars = {
            username = "suchir";
            fullname = "Suchir Kavi";
            email = "suchirkavi@gmail.com";
          };
          hostModule = ./hosts/matic-suchir-0;
        };
      };
    };
}
