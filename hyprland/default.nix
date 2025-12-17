{
  lib,
  config,
  ...
}:
{
  imports = [
    ./hypr.nix
    ./caelestia.nix
    ./hyprpanel.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./wlogout.nix
  ];

  options = {
    hyprland.enable = lib.mkEnableOption "Enable hyprland module";
  };
  config = lib.mkIf config.hyprland.enable {
    hypr.enable = lib.mkDefault true;
    caelestia.enable = lib.mkDefault true;
    hyprpanel.enable = lib.mkDefault false;
    hyprlock.enable = lib.mkDefault true;
    hyprpaper.enable = lib.mkDefault true;
    wlogout.enable = lib.mkDefault true;
  };
}
