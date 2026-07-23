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
        name = "Kanagawa";
      };
      theme = {
        name = "Kanagawa-B";
        package = pkgs.kanagawa-gtk-theme;
      };
      gtk4.theme = null;
    };
  };
}
