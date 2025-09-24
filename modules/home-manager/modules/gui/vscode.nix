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

      profiles.default = {
        userSettings = {
          "editor.formatOnSave" = true;
          "editor.inlayHints.enabled" = "offUnlessPressed";

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

          "rust-analyzer"."inlayHints" = {
            "bindingModeHints"."enable" = true;
            "closureCaptureHints"."enable" = true;
            "expressionAdjustmentHints"."enable" = "always";
            "lifetimeElisionHints"."enable" = "always";
            "rangeExclusiveHints"."enable" = true;
            "discriminantHints"."enable" = "always";
            "implicitDrops"."enable" = true;
          };
        };

        extensions = with pkgs.vscode-extensions; [
          rust-lang.rust-analyzer
          jnoortheen.nix-ide
          arrterian.nix-env-selector
          github.copilot
          bazelbuild.vscode-bazel
          github.github-vscode-theme
        ];
      };
    };
  };
}
