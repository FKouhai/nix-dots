{
  lib,
  config,
  ...
}:
{
  imports = [
    ./conf
  ];

  options = {
    gtk-mod.enable = lib.mkEnableOption "Enable gtk module";
  };
  config = lib.mkMerge [
    {
      gtk-mod.enable = lib.mkDefault true;
    }
    (lib.mkIf config.gtk-mod.enable {
      gtk-conf.enable = lib.mkDefault false;
    })
  ];
}
