{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    yazi.enable = lib.mkEnableOption "Enable yazi module";
  };

  config = lib.mkIf config.yazi.enable {
    home.packages = [
      (pkgs.writeShellScriptBin "yazi-open" ''
        dir="''${1#file://}"
        exec ghostty -e yazi "$dir"
      '')
    ];

    xdg.desktopEntries."yazi-open" = {
      name = "Yazi";
      exec = "yazi-open %u";
      terminal = false;
      mimeType = [ "inode/directory" ];
    };

    xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
      [filechooser]
      cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
      env=TERMCMD=ghostty -e
      default_dir=$HOME/Downloads
    '';

    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      shellWrapperName = "yy";
      settings = {
        manager = {
          linemode = "size";
          "show-hidden" = true;
          "show-symlink" = true;
          "sort-by" = "natural";
          "sort-dir-first" = true;
          "sort-reverse" = false;
          "sort-sensitive" = false;
        };
      };
    };
  };
}
