{pkgs, ...}: {
  home.packages = with pkgs; [nix-your-shell];
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        if command -q nix-your-shell
          nix-your-shell fish | source
        end
      '';
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
