{lib, config, ...}:
{

  options = {
    trouble.enable = lib.mkEnableOption "Enable trouble nixvim plugin module";
  };

  config = lib.mkIf config.trouble.enable {
  programs.nixvim.plugins.trouble = {
    enable = true;
  };
 };
}
