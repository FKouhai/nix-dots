{
  lib,
  ...
}:
{
  imports = [
    ./caelestia.nix
    ./noctalia
    ./hyprpanel.nix
  ];

  options = {
    bars.enable = lib.mkEnableOption "Enable bars module";
  };

  config = {
    bars = {
      caelestia.enable = lib.mkDefault false;
      noctalia.enable = lib.mkDefault false;
      hyprpanel.enable = lib.mkDefault false;
    };
  };
}
