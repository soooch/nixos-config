{
  inputs,
  vars,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = {inherit inputs vars;};
  home-manager.users.${vars.username} = import ./homes/default.nix;
}
