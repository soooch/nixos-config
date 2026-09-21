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
    # fish is configured by home-manager rather than programs.fish; it is
    # still listed in /etc/shells by modules/shells.nix.
    ignoreShellProgramCheck = true;
  };
}
