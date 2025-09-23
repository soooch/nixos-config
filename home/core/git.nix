{vars, ...}: {
  programs = {
    git = {
      enable = true;

      userName = vars.fullname;
      userEmail = vars.email;

      difftastic.enable = true;
      extraConfig = {
        merge.conflictstyle = "zdiff3";
      };
    };
  };
}
