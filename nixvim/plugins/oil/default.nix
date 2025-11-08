{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    oil.enable = lib.mkEnableOption "Enable oil nixvim plugin module";
  };

  config = lib.mkIf config.oil.enable {
    programs.nixvim.plugins.oil = {
      enable = true;
      settings = {
        win_options = {
          signcolumn = "yes:2";
        };
      };
    };
    programs.nixvim.plugins.oil-git-status = {
      enable = true;
    };
  };
}
