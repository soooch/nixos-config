{
  inputs,
  vars,
  ...
}:
{
  imports = [ inputs.determinate.darwinModules.default ];

  # Determinate Nixd owns /etc/nix/nix.conf (flakes are on by default), so
  # nix-darwin's `nix.*` options are disabled by the module above. Extra
  # settings go to /etc/nix/nix.custom.conf via customSettings.
  determinateNix = {
    enable = true;
    customSettings = {
      trusted-users = [
        "root"
        vars.username
      ];
    };
  };
}
