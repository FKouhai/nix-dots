{pkgs, lib, config, ...}:
{

  options = {
    which-key.enable = lib.mkEnableOption "Enable which-key nixvim plugin module";
  };

  config = lib.mkIf config.which-key.enable {
  programs.nixvim.plugins.which-key = {
    enable = true;
  };
 };
}
