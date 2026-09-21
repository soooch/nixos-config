{ pkgs, vars, ... }:
{
  # Don't forget to set a password with `passwd`.
  users.users.${vars.username} = {
    isNormalUser = true;
    description = vars.fullname;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };
}
