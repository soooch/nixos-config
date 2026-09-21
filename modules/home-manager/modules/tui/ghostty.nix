{
  inputs,
  pkgs,
  ...
}:
{
  programs = {
    ghostty = {
      enable = true;
      # The upstream flake only builds on Linux; nixpkgs wraps the official
      # macOS app bundle as ghostty-bin.
      package =
        if pkgs.stdenv.isDarwin then
          pkgs.ghostty-bin
        else
          inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default;
      settings = {
        theme = "Rose Pine";
        font-size = 11;
      };
    };
  };
}
