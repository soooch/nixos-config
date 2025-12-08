{pkgs, ...}: {
  programs = {
    fish = {
      enable = true;
      plugins = [
        {
          name = "fzf.fish";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
      ];
      shellAliases = {
        sshx = "TERM=xterm-256color ssh";
      };
    };
  };
}
