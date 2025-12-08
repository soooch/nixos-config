{
  pkgs,
  lib,
  ...
}:
{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
      "toml"
      "make"
    ];

    userSettings = {
      vim_mode = true;

      lsp = {
        rust-analyzer = {
          binary = {
            path = lib.getExe pkgs.rust-bin.stable.latest.rust-analyzer;
          };
        };
        nil = {
          initialization_options = {
            formatting = {
              command = [ (lib.getExe pkgs.nixfmt-rfc-style) ];
            };
          };
        };
      };

      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };

      # assistant = {
      #   enabled = true;
      #   version = "2";
      #   default_open_ai_model = null;
      #   ### PROVIDER OPTIONS
      #   ### zed.dev models { claude-3-5-sonnet-latest } requires github connected
      #   ### anthropic models { claude-3-5-sonnet-latest claude-3-haiku-latest claude-3-opus-latest  } requires API_KEY
      #   ### copilot_chat models { gpt-4o gpt-4 gpt-3.5-turbo o1-preview } requires github connected
      #   default_model = {
      #     provider = "zed.dev";
      #     model = "claude-3-7-sonnet-latest";
      #   };

      #   #                inline_alternatives = [
      #   #                    {
      #   #                        provider = "copilot_chat";
      #   #                        model = "gpt-3.5-turbo";
      #   #                    }
      #   #                ];
      # };

      auto_update = false;

      hour_format = "hour12";

      ## tell zed to use direnv and direnv can use a flake.nix enviroment.
      # load_direnv = "shell_hook";
      # base_keymap = "VSCode";
      # theme = {
      #   mode = "system";
      #   light = "One Light";
      #   dark = "One Dark";
      # };
      # show_whitespaces = "all";
      # ui_font_size = 16;
      # buffer_font_size = 16;
    };
  };
}
