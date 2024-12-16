{pkgs, lib, config, ...}:
{

  options = {
    image.enable = lib.mkEnableOption "Enable image nixvim plugin module";
  };

  config = lib.mkIf config.image.enable {
  programs.nixvim.plugins.image = {
    enable = true;
    backend = "kitty";
  };
 };
}
