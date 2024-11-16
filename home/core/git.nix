{
  programs = {
    git = {
      enable = true;

      userName = "Suchir Kavi";
      userEmail = "suchirkavi@gmail.com";

      difftastic.enable = true;
      extraConfig = {
        merge.conflictstyle = "zdiff3";
      };
    };
  };
}
