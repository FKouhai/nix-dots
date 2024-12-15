{pkgs, lib, config, ...}:
{
  options = {
    sitter.enable = lib.mkEnableOption "Enable sitter nixvim plugin module";
  };

  config = lib.mkIf config.sitter.enable {
    programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;
      folding = false;
      settings = {
        indent.enable = true;
        highlight.enable = true;
        auto_install = true;
      };
    };
    treesitter-refactor = {
      enable = true;
      highlightDefinitions = {
        enable = true;
        clearOnCursorMove = false;
      };
    };
    hmts.enable = true;
 };
 };
}
