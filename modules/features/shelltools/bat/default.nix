{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    bat.enable = lib.mkEnableOption "Enable bat module";
  };

  config = lib.mkIf config.bat.enable {
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        prettybat
      ];
    };
  };
}
