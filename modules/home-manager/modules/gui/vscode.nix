{
  pkgs,
  lib,
  ...
}: {
  programs = {
    vscode = {
      enable = true;

      profiles.default = {
        userSettings = {
          "editor.formatOnSave" = true;
          "editor.inlayHints.enabled" = "offUnlessPressed";

          "nix.enableLanguageServer" = true;
          "nix.formatterPath" = lib.getExe pkgs.alejandra;
          "nix.serverPath" = lib.getExe pkgs.nil;
          "nix.serverSettings" = {
            "nil" = {
              "formatting"."command" = [(lib.getExe pkgs.alejandra)];
              "nix"."flake"."autoEvalInputs" = true;
            };
            "nixd" = {
              "formatting"."command" = lib.getExe pkgs.alejandra;
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
          ms-python.python
        ];
      };
    };
  };
}
