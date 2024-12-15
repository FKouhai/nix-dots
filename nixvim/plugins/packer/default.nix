{pkgs, lib, config, ...}:
{

  options = {
    packer.enable = lib.mkEnableOption "Enable packer nixvim plugin module";
  };

  config = lib.mkIf config.packer.enable {
  programs.nixvim.plugins.packer = {
    enable = true;
  };
 };
}
