{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    toggleterm.enable = lib.mkEnableOption "Enable toggleterm nixvim plugin module";
  };

  config = lib.mkIf config.toggleterm.enable {
    programs.nixvim.plugins.toggleterm = {
      enable = true;
      settings = {
        directions = "horizontal";
      };
    };
  };
}
