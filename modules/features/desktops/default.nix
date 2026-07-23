{
  lib,
  config,
  ...
}:
{
  imports = [
    ./hyprland
  ];

  options = {
    desktops.enable = lib.mkEnableOption "Enable desktops module";
  };

  config = lib.mkMerge [
    {
      desktops.enable = lib.mkDefault true;
    }
    (lib.mkIf config.desktops.enable {
      desktops.hyprland.enable = lib.mkDefault true;
    })
  ];
}
