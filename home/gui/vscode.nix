{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    nil
  ];

  programs = {
    vscode = {
      enable = true;

      userSettings = {
        "editor.formatOnSave" = true;

        "nix.enableLanguageServer" = true;
        "nix.formatterPath" = "alejandra";
        "nix.serverPath" = "nil";
        "nix.serverSettings" = {
          "nil" = {
            "formatting"."command" = ["alejandra"];
          };
        };
      };

      extensions = with pkgs.vscode-extensions; [
        rust-lang.rust-analyzer
        jnoortheen.nix-ide
      ];
    };
  };
}
