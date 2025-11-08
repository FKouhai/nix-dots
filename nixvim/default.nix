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
    ./keymaps.nix
    ./plugins/blink
    ./plugins/clipboard-image
    ./plugins/cmp
    ./plugins/code_companion
    ./plugins/dashboard
    ./plugins/git
    ./plugins/harpoon
    ./plugins/images
    ./plugins/lint
    ./plugins/lsp
    ./plugins/lualine
    ./plugins/luasnip
    ./plugins/lzn
    ./plugins/markdown-preview
    ./plugins/oil
    ./plugins/opencode
    ./plugins/presence
    ./plugins/telekasten
    ./plugins/telescope
    ./plugins/toggleterm
    ./plugins/tree-sitter
    ./plugins/trouble
    ./plugins/which-key
    ./vimopts.nix
  ];

  options = {
    nixvimcfg.enable = lib.mkEnableOption "Enable nixvim config module";
  };
  config = lib.mkIf config.nixvimcfg.enable {
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
    opencode.enable = lib.mkDefault true;
    lzn.enable = lib.mkDefault true;
    presence.enable = lib.mkDefault true;
    sitter.enable = lib.mkDefault true;
    telekasten.enable = lib.mkDefault true;
    telescope.enable = lib.mkDefault false;
    toggleterm.enable = lib.mkDefault true;
    trouble.enable = lib.mkDefault true;
    which-key.enable = lib.mkDefault true;

    # basic nixvim config
    programs.nixvim = {
      enable = true;
      package = pkgs.neovim-unwrapped.overrideAttrs {
        version = "v0.12.0-dev";
        src = pkgs.fetchFromGitHub {
          owner = "neovim";
          repo = "neovim";
          rev = "af5ac171bde3ae7f961a23e9464309cee7ef9c13";
          hash = "sha256-z2lLrDK3WRgGS9LA4KEQRgYxnZiVXh+bdg09puaBfk4=";
        };
      };
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
            transparent = true;
            theme = "dragon";
            terminalColors = true;
            commentStyle = {
              italic = true;
            };

          };

        };
      };
    };
  };

}
