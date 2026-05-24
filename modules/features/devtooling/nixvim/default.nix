{
  lib,
  config,
  inputs,
  pkgs,
  osConfig,
  ...
}:
{
  options = {
    nixvim.enable = lib.mkEnableOption "Enable nixvim module";
  };

  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
      _module.args.inputs = inputs;
      enable = true;
      nixpkgs.config.allowUnfree = true;
      nixpkgs.overlays = [ inputs.kanoxo.overlays.default ];
      imports = [
        inputs.frostvim.nixvimModules.base
        inputs.frostvim.nixvimModules.blink
        inputs.frostvim.nixvimModules.clipboard-image
        inputs.frostvim.nixvimModules.dashboard
        inputs.frostvim.nixvimModules.dap
        inputs.frostvim.nixvimModules.git
        inputs.frostvim.nixvimModules.go
        inputs.frostvim.nixvimModules.images
        inputs.frostvim.nixvimModules.lint
        inputs.frostvim.nixvimModules.lsp
        inputs.frostvim.nixvimModules.lualine
        inputs.frostvim.nixvimModules.luasnip
        inputs.frostvim.nixvimModules.markdown-preview
        inputs.frostvim.nixvimModules.mini
        inputs.frostvim.nixvimModules.noice
        inputs.frostvim.nixvimModules.oil
        inputs.frostvim.nixvimModules.opencode
        inputs.frostvim.nixvimModules.presence
        inputs.frostvim.nixvimModules.quicker
        inputs.frostvim.nixvimModules.snacks
        inputs.frostvim.nixvimModules.telekasten
        inputs.frostvim.nixvimModules.tree-sitter
        inputs.frostvim.nixvimModules.trouble
        inputs.frostvim.nixvimModules.web-devicons
        inputs.frostvim.nixvimModules.which-key
        inputs.frostvim.nixvimModules.kanoxo
      ];

      kanoxo = {
        enable      = true;
        variant     = "wave";
        transparent = true;
      };

      plugins = {
        copilot-lsp = {
          enable = true;
          luaConfig.post = ''
            vim.g.copilot_nes_debounce = 500
            vim.lsp.enable("copilot_ls")
            vim.keymap.set("n", "<tab>", function()
                local bufnr = vim.api.nvim_get_current_buf()
                local state = vim.b[bufnr].nes_state
                if state then
                    -- Try to jump to the start of the suggestion edit.
                    -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
                    local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
                        or (
                            require("copilot-lsp.nes").apply_pending_nes()
                            and require("copilot-lsp.nes").walk_cursor_end_edit()
                        )
                    return nil
                else
                    -- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
                    return "<C-i>"
                end
            end, { desc = "Accept Copilot NES suggestion", expr = true })
          '';
        };
        copilot-lua.enable = true;
        avante = {
          enable = true;
          settings = {
            provider = "opencode";
            acp_providrs = {
              opencode = {
                command = "opencode";
                args = [ "acp" ];
              };
            };
          };
        };

        claude-code.enable = true;

        lsp.servers.nixd.settings =
          let
            flake = ''(builtins.getFlake "${inputs.self}")'';
          in
          {
            nixpkgs.expr = "import ${flake}.inputs.nixpkgs {}";
            nixos.expr = "${flake}.nixosConfigurations.${osConfig.host.hostName}.options";
          };

        minuet = {
          enable = false;
          settings = {
            lsp = {
              enabled_ft = [
                "go"
                "yaml"
                "elixir"
              ];
              enabled_auto_trigger_ft = [
                "go"
                "yaml"
                "elixir"
              ];
            };
            provider = "gemini";
            provider_options = {
              api_key = "GEMINI_API_KEY";
              end_point = "https://generativelanguage.googleapis.com/v1beta/models";
              model = "gemini-flash-latest";
              stream = true;
              optional = {
                max_tokens = 256;
                thinkingConfig = {
                  thinkingBudget = 0;
                };
                safetySettings = {
                  threshold = "BLOCK_ONLY_HIGH";
                  category = "HARM_CATEGORY_DANGEROUS_CONTENT";
                };
              };
            };
          };
        };
      };
    };
  };
}
