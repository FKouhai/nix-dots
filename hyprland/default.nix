{
  lib,
  config,
  vars,
  ...
}:
{
  imports = [
    ./hypr.nix
    ./bars
    ./hyprlock.nix
    ./hyprpaper.nix
    ./wlogout.nix
  ];

  options = {
    hyprland.enable = lib.mkEnableOption "Enable hyprland module";
  };
  config = lib.mkIf config.hyprland.enable {
    hypr.enable = lib.mkDefault true;
    # Shell-specific bar configuration using enum logic
    bars.noctalia.enable = lib.mkIf (vars.shell == "noctalia") true;
    bars.caelestia.enable = lib.mkIf (vars.shell == "caelestia") true;
    bars.hyprpanel.enable = lib.mkIf (vars.shell == "hyprpanel") true;
    hyprlock.enable = lib.mkDefault true;
    hyprpaper.enable = lib.mkDefault true;
    wlogout.enable = lib.mkDefault true;
  };
}
