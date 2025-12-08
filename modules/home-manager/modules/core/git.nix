{ vars, ... }:
{
  programs = {
    git = {
      enable = true;

      settings = {
        user = {
          name = vars.fullname;
          email = vars.email;
        };

        # https://blog.gitbutler.com/how-git-core-devs-configure-git
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

    difftastic = {
      enable = true;
      git.enable = true;
    };
  };
}
