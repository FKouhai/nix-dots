{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    starship.enable = lib.mkEnableOption "Enable starship module";
  };
  config = lib.mkIf config.starship.enable {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
