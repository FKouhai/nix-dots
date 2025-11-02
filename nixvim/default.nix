{
  self,
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    # import home manager module
    inputs.nixvim.homeModules.nixvim
    # import plugin config
    ./plugins/lualine
    ./plugins/packer
    ./plugins/oil
    ./plugins/overseer
    ./plugins/telescope
    ./plugins/git
    ./plugins/cmp
    ./plugins/lsp
    ./plugins/lint
    ./plugins/harpoon
    ./plugins/dashboard
    ./plugins/tree-sitter
    ./plugins/telekasten
    ./plugins/toggleterm
    ./plugins/clipboard-image
    ./plugins/which-key
    ./plugins/markdown-preview
    ./plugins/images
    ./plugins/presence
    ./plugins/blink
    ./plugins/trouble
    ./plugins/hot-reload
    ./plugins/luasnip
    ./plugins/code_companion
    ./plugins/avante
    ./keymaps.nix
    ./vimopts.nix
  ];

  options = {
    nixvimcfg.enable = lib.mkEnableOption "Enable nixvim config module";
  };
  config = lib.mkIf config.nixvimcfg.enable {
    avante.enable = lib.mkDefault true;
    blink.enable = lib.mkDefault false;
    clipboard-image.enable = lib.mkDefault true;
    cmp.enable = lib.mkDefault true;
    companion.enable = lib.mkDefault true;
    dashboard.enable = lib.mkDefault true;
    git_helpers.enable = lib.mkDefault true;
    harpoon.enable = lib.mkDefault true;
    image.enable = lib.mkDefault true;
    lint.enable = lib.mkDefault true;
    lsp.enable = lib.mkDefault true;
    lualine.enable = lib.mkDefault true;
    luasnip.enable = lib.mkDefault true;
    markdown-preview.enable = lib.mkDefault true;
    oil.enable = lib.mkDefault true;
    overseer.enable = lib.mkDefault false;
    packer.enable = lib.mkDefault true;
    presence.enable = lib.mkDefault true;
    reload.enable = lib.mkDefault true;
    sitter.enable = lib.mkDefault true;
    telekasten.enable = lib.mkDefault true;
    telescope.enable = lib.mkDefault true;
    toggleterm.enable = lib.mkDefault true;
    trouble.enable = lib.mkDefault true;
    which-key.enable = lib.mkDefault true;

    # basic nixvim config
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      luaLoader.enable = false;

      extraConfigLua = "require('go').setup()";

      extraPlugins = with pkgs.vimPlugins; [
        plenary-nvim
        go-nvim
        nvim-treesitter.withAllGrammars
      ];

      plugins = {
        web-devicons = {
          enable = true;
        };

        timerly.enable = true;
        noice.enable = true;

        mini = {
          enable = true;

          modules = {
            animate = {
              cursor = {
                enable = true;
              };
              scroll = {
                enable = true;
              };
              resize = {
                enable = true;
              };
              open = {
                enable = true;
              };
              close = {
                enable = true;
              };
            };
          };
        };
      };

      colorschemes = {
        kanagawa = {
          enable = true;

          settings = {
            #background = "dark";
            transparent = true;
            #undercurl = true;
            #terminal_colors = true;
            theme = "dragon";
            terminalColors = true;
            commentStyle = {
              italic = true;
            };

            #styles = {
            #  comments = {
            #    italic = true;
            #  };
            #
            #              functions = {
            #                italic = true;
            #              };
            #
            #              keywords = {
            #                bold = true;
            #              };

            #              statement_style = {
            ##                bold = true;
            #              };

            #            };

          };

        };
      };
    };
  };

}
