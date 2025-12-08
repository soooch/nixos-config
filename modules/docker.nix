{ vars, ... }:
{
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ vars.username ];
}
