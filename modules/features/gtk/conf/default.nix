{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
{
  options = {
    gtk-conf.enable = lib.mkEnableOption "Enable gtk module";
  };

  config = lib.mkIf config.gtk-conf.enable {
    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.kanagawa-icon-theme;
        name = osConfig.host.themeData.gtk.iconName;
      };
      theme = {
        inherit (osConfig.host.themeData.gtk) name;
        package = pkgs.kanagawa-gtk-theme;
      };
      gtk4.theme = null;
    };
  };
}
