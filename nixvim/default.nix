{
  lib,
  config,
  ...
}:
{
  imports = [
    ./plugins/lualine
    ./plugins/packer
    ./plugins/oil
    ./plugins/telescope
    ./plugins/git
    ./plugins/cmp
    ./plugins/lsp
    ./plugins/lint
    ./plugins/harpoon
    ./plugins/dashboard
    ./plugins/tree-sitter
  ];

  options = {
    nixvimcfg.enable = lib.mkEnableOption "Enable nixvim config module";
  };
  config = lib.mkIf config.nixvimcfg.enable {
    packer.enable = lib.mkDefault true;
    oil.enable = lib.mkDefault true;
    lualine.enable = lib.mkDefault true;
    telescope.enable = lib.mkDefault true;
    git_helpers.enable = lib.mkDefault true;
    cmp.enable = lib.mkDefault true;
    lsp.enable = lib.mkDefault true;
    lint.enable = lib.mkDefault true;
    harpoon.enable = lib.mkDefault true;
    dashboard.enable = lib.mkDefault true;
    sitter.enable = lib.mkDefault true;
  };
}
