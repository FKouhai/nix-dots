{pkgs, lib, config, ...}:
{

  options = {
    clipboard-image.enable = lib.mkEnableOption "Enable clipboard-image nixvim plugin module";
  };

  config = lib.mkIf config.clipboard-image.enable {
  programs.nixvim.plugins.clipboard-image = {
    enable = true;
      clipboardPackage = null;
      default = {
        imgDir = "/home/franky/vaults/personal/assets/imgs";
      };
  };
 };
}
