{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    nil
    # can't seem to get this one to work for options.
    nixd
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
            "nix"."flake"."autoEvalInputs" = true;
          };
          "nixd" = {
            "formatting"."command" = "alejandra";
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
