{vars, ...}: {
  programs = {
    git = {
      enable = true;

      userName = vars.fullname;
      userEmail = vars.email;

      difftastic.enable = true;

      # https://blog.gitbutler.com/how-git-core-devs-configure-git
      extraConfig = {
        column.ui = "auto";
        branch.sort = "-committerdate";
        tag.sort = "version:refname";
        init.defaultBranch = "main";
        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          mnemonicPrefix = "true";
          renames = "true";
        };
        help.autocorrect = "prompt";
        rerere = {
          enabled = "true";
          autoupdate = "true";
        };
        rebase = {
          autoSquash = "true";
          autoStash = "true";
        };
        merge.conflictstyle = "zdiff3";
        pull.rebase = "true";
      };
    };
  };
}
