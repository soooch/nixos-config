{
  inputs,
  vars,
  ...
}:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.username}.imports = [ ./homes/default.nix ];
  };
}
