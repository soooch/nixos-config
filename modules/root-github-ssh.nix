# ssh access to GitHub for root, using the user's key and GitHub's host key.
# Root has no identity of its own.
{ config, vars, ... }:
{
  programs.ssh = {
    knownHosts."github.com".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";

    extraConfig = ''
      Match localuser root host github.com
        IdentityFile ${config.users.users.${vars.username}.home}/.ssh/id_ed25519
    '';
  };
}
