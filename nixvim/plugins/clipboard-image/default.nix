{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    clipboard-image.enable = lib.mkEnableOption "Enable clipboard-image nixvim plugin module";
  };

  config = lib.mkIf config.clipboard-image.enable {
    programs.nixvim.plugins.clipboard-image = {
      enable = false;
      clipboardPackage = null;
      settings = {
        default = {
          imgDir = "/home/franky/vaults/personal/assets/imgs";
        };
      };
    };
  };
}
