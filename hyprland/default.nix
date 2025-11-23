{
  lib,
  config,
  ...
}:
{
  imports = [
    ./hypr.nix
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
    hyprpanel.enable = lib.mkDefault true;
    hyprlock.enable = lib.mkDefault true;
    hyprpaper.enable = lib.mkDefault true;
    wlogout.enable = lib.mkDefault true;
  };
}