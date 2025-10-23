{
  lib,
  config,
  ...
}:
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
          auto_install = false;
          ensure_instaled = "all";
        };
      };
      treesitter-refactor = {
        enable = false;
        settings = {
          highlight_definitions = {
            enable = true;
            clear_on_cursor_move = false;
          };
        };
      };
      hmts.enable = false;
    };
  };
}
