{
  description = "Suchir's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    home-manager,
    rust-overlay,
    ...
  } @ inputs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    nixosConfigurations = let
      commonModules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
        {
          nixpkgs.overlays = [rust-overlay.overlays.default];
        }
      ];
      defSystem = {
        vars,
        hostModule,
      }: let
        specialArgs = {
          inherit inputs;
          inherit vars;
        };
      in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [
              hostModule
              {
                home-manager.extraSpecialArgs = specialArgs;
                home-manager.users.${vars.username} = import ./home;
              }
            ]
            ++ commonModules;
          inherit specialArgs;
        };
    in {
      lovelace = defSystem {
        vars = {
          username = "soooch";
          fullname = "Suchir Kavi";
          email = "suchirkavi@gmail.com";
        };
        hostModule = ./hosts/lovelace;
      };
      matic1 = defSystem {
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
