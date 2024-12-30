{pkgs, lib, config, ...}:
{

  options = {
    luasnip.enable = lib.mkEnableOption "Enable luasnip nixvim plugin module";
  };

  config = lib.mkIf config.luasnip.enable {
  programs.nixvim.plugins.luasnip = {
    enable = true;
    fromVscode = [
        {
          paths = "${pkgs.vimPlugins.friendly-snippets}";

        }
      ];
    settings = {
      enable_autosnippets = true;
      exit_roots = false;
      link_roots = true;
      keep_roots = true;
      update_events = [
          "TextChanged"
          "TextChangedI"
        ];
      };
  };
 };
}
