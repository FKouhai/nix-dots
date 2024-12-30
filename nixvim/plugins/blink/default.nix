{ config,lib, ...}:
{
  options = {
    blink.enable = lib.mkEnableOption "Enable blink nixvim plugin module";
  };

  config = lib.mkIf config.blink.enable {
  programs.nixvim.plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap = {
        preset = "default";
        };
      };
  };
 };
}
