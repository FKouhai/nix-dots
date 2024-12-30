{
  lib,
  config,
  ...
}: {
  imports = [
    ./conf
  ];

  options = {
    gtk-mod.enable = lib.mkEnableOption "Enable gtk module";
  };
  config = lib.mkIf config.gtk-mod.enable {
    gtk-conf.enable = lib.mkDefault true;
  };
}
