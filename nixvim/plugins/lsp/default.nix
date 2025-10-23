{
  self,
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    lsp.enable = lib.mkEnableOption "Enable lsp nixvim plugins module";
  };
  config = lib.mkIf config.lsp.enable {
    programs.nixvim.plugins = {
      lsp-format = {
        enable = true;
        lspServersToEnable = [
          "gopls"
          "nixd"
        ];
      };
      lsp = {
        enable = true;
        inlayHints = true;
        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };
          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            grn = "rename";
          };
        };
        servers = {
          gopls = {
            enable = true;
            settings.formatting.command = "gofmt";
          };
          lua_ls.enable = true;
          gleam.enable = true;
          pyrefly.enable = true;
          marksman.enable = false;
          markdown_oxide = {
            enable = true;
            filetypes = [
              "markdown"
              "md"
            ];
          };
          tflint.enable = true;
          astro.enable = true;
          nixd = {
            enable = true;
            settings =
              let
                flake = ''(builtins.getFlake "${inputs.self}")'';
                system = ''''${builtins.currentSystem}'';
              in
              {
                nixpkgs.expr = "import ${flake}.inputs.nixpkgs {}";
                nixos.expr = "${flake}.nixosConfiguration.kraken.options";
                nixvim.expr = "${flake}.packages.${system}.nvim.options";
                formatting.command = [ "nixfmt" ];
              };
          };
          statix.enable = true;
          ts_ls.enable = true;
          elixirls = {
            enable = true;
          };
          rust_analyzer = {
            enable = true;
            installRustc = false;
            installCargo = false;
            settings.formatting.command = "cargo fmt";
          };
          terraform_lsp.enable = true;
        };
      };
    };
  };
}
