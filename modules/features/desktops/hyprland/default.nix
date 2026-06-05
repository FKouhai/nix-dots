{
  lib,
  config,
  osConfig,
  ...
}:
{
  imports = [
    ./hypr.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./wlogout.nix
  ];

  options = {
    hyprland.enable = lib.mkEnableOption "Enable hyprland module";
  };
  config = lib.mkIf config.hyprland.enable {
    hypr.enable = lib.mkDefault true;
    # Bar selection based on host.bar option
    bars = {
      noctalia.enable = lib.mkIf (osConfig.host.bar == "noctalia") true;
    };
    hyprlock.enable = lib.mkForce false;
    hyprpaper.enable = lib.mkForce false;
    wlogout.enable = lib.mkForce false;
  };
}
