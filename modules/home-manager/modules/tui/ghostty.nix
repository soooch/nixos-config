{ inputs, ... }:
{
  programs = {
    ghostty = {
      enable = true;
      package = inputs.ghostty.packages.x86_64-linux.default;
      settings = {
        theme = "Rose Pine";
        font-size = 11;
      };
    };
  };
}
