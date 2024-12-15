{pkgs, lib, config, ...}:
{

  options = {
    oil.enable = lib.mkEnableOption "Enable oil nixvim plugin module";
  };

  config = lib.mkIf config.packer.enable {
  programs.nixvim.plugins.oil = {
    enable = true;
  };
 };
}
