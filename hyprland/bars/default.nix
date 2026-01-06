{
  lib,
  ...
}:
{
  imports = [
    ./caelestia.nix
    ./noctalia.nix
    ./hyprpanel.nix
  ];

  options = {
    bars.enable = lib.mkEnableOption "Enable bars module";
  };

  config = {
    bars.caelestia.enable = lib.mkDefault false;
    bars.noctalia.enable = lib.mkDefault false;
    bars.hyprpanel.enable = lib.mkDefault false;
  };
}
