{
  lib,
  config,
  vars,
  pkgs,
  ...
}:
{
  options = {
    hyprpaper.enable = lib.mkEnableOption "Enable hyprpaper module";
  };
  config = lib.mkIf config.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      package = pkgs.hyprpaper;
      settings = {
        ipc = "on";
        splash = false;
        preload = [ vars.wallpaper ];
        wallpaper = [
          "${vars.mainMonitor.name},${vars.wallpaper}"
          "${vars.secondaryMonitor.name},${vars.wallpaper}"
        ];
      };
    };
  };
}