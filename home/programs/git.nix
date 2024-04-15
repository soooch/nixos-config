{
  pkgs,
  config,
  ...
}: {
  programs = {
    git = {
      enable = true;

      userName = "Suchir Kavi";
      userEmail = "suchirkavi@gmail.com";
    };
  };
}
