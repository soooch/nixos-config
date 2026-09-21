{ vars, ... }:
{
  # The macOS user is created by the installer, not by nix-darwin. We only
  # describe it here so home-manager and nix-darwin know where it lives.
  users.users.${vars.username} = {
    name = vars.username;
    home = "/Users/${vars.username}";
    description = vars.fullname;
  };

  # Required by nix-darwin for user-scoped options (homebrew, system.defaults).
  system.primaryUser = vars.username;
}
