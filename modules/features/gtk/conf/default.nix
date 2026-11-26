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
      # Base theme required by Noctalia's built-in gtk3/gtk4 templates:
      # its apply.sh hook selects adw-gtk3/adw-gtk3-dark and layers
      # noctalia.css on top. adw-gtk3 is the only GTK3 theme that reads
      # the libadwaita color names Noctalia generates; without it GTK3
      # apps (e.g. Nemo) fall back to default Adwaita light.
      gtk3.theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3-dark";
      };
      colorScheme = "dark";
      # Keep gtk4.theme unset: HM would manage gtk-4.0/gtk.css as a
      # store symlink, fighting Noctalia's apply.sh which owns that file.
      gtk4.theme = null;
    };
  };
}
