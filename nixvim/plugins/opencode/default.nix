{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    opencode.enable = lib.mkEnableOption "Enable opencode nixvim plugin module";
  };

  config = lib.mkIf config.opencode.enable {

    programs.nixvim.plugins = {
      snacks = {
        enable = true;
        settings = {
          input.enabled = true;
          terminal.enable = true;
          picker = {
            ui_select = true;
          };
        };
      };
      opencode = {
        enable = true;
        settings = {
          port = 9999;
        };
      };
    };
  };
}
