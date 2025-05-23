{
  lib,
  config,
  ...
}:
{
  options = {
    cmp.enable = lib.mkEnableOption "Enable cmp nixvim plugins module";
  };
  config = lib.mkIf config.cmp.enable {
    programs.nixvim = {
      opts.completeopt = [
        "menu"
        "menuone"
        "noselect"
      ];
      plugins = {
        luasnip.enable = true;
        cmp-omni.enable = true;
        cmp-dap.enable = true;
        dap-go.enable = true;
        dap-ui.enable = true;
        cmp-nvim-lsp.enable = true;
        cmp-nvim-lsp-document-symbol.enable = true;
        cmp-nvim-lsp-signature-help.enable = true;
        cmp-dictionary.enable = true;
        lspkind = {
          enable = false;
          cmp = {
            enable = true;
            menu = {
              code_companion = "[AI]";
              nvim_lsp = "[LSP]";
              nvim_lua = "[api]";
              path = "[path]";
              luasnip = "[snip]";
              buffer = "[buffer]";
              neorg = "[neorg]";
            };
          };
        };

        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
            mapping = {
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-e>" = "cmp.mapping.close()";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
            };

            sources = [
              { name = "path"; }
              { name = "codecompanion"; }
              { name = "nvim_lsp"; }
              { name = "luasnip"; }
              {
                name = "buffer";
                # Words from other open buffers can also be suggested.
                option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
              }
              { name = "neorg"; }
            ];
          };
        };
      };
    };
  };
}
