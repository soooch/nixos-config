# Docker for the user: the CLI, and a Linux VM running the daemon (Colima),
# started at login and set as the active docker context.
{ pkgs, ... }:
{
  home.packages = [ pkgs.docker ];

  services.colima = {
    enable = true;

    # Declared rather than left to the option's default profile, which stops
    # applying as soon as a host sets anything on `profiles.default`.
    profiles.default = {
      isService = true;
      isActive = true;
    };
  };
}
