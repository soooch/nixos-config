{ vars, ... }:
{
  nix = {
    channel.enable = false;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        vars.username
      ];
    };
  };
}
