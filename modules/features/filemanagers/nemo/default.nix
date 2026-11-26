{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    filemanagers.nemo.enable = lib.mkEnableOption "Enable nemo file manager";
  };

  config = lib.mkIf config.filemanagers.nemo.enable {
    home.packages = [
      (pkgs.nemo-with-extensions.override {
        extensions = with pkgs; [
          nemo-preview
          nemo-seahorse
        ];
      })
      pkgs.file-roller
      # Thumbnailer providers (freedesktop .thumbnailer files Nemo
      # discovers via XDG_DATA_DIRS; images are covered by gdk-pixbuf).
      pkgs.ffmpegthumbnailer # video + audio covers
      pkgs.evince # pdf, postscript, djvu, tiff, xps, comics
      pkgs.gnome-epub-thumbnailer # epub + mobi
    ];

    # Nemo is GTK3 and picks up the Noctalia-generated GTK theme
    # (programs.noctalia.settings.theme.templates.builtin_ids includes
    # "gtk3" and "gtk4"). Noctalia's gtk templates require adw-gtk3 as
    # the base theme (selected in modules/features/gtk/conf); do not set
    # gtk.theme here and keep stylix.targets.gtk disabled so Noctalia
    # remains the theme owner.
    # Default handler lives in modules/home.nix
    # (xdg.mimeApps "inode/directory" = "nemo.desktop"); yazi stays
    # installed for terminal use.
  };
}
