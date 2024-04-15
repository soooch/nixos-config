{
  pkgs,
  config,
  ...
}: {
  programs = {
    google-chrome = {
      enable = true;

      # extensions not supported for proprietary google-chrome
      # extensions = [
        # {id = "";}  // extension id, query from chrome web store
      # ];
    };
  };
}
