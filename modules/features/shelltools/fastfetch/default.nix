{
  lib,
  config,
  ...
}:
{
  options.fastfetch.enable = lib.mkEnableOption "Enable fastfetch module";

  config = lib.mkIf config.fastfetch.enable {
    programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = "nixos";
          padding.right = 1;
        };
        display = {
          separator = "   ";
          color.keys = "cyan";
        };
        modules = [
          "break"
          {
            type = "custom";
            format = "| 󰊧 HARDWARE";
          }
          {
            type = "cpu";
            key = "󰻠  CPU";
          }
          {
            type = "gpu";
            key = "󰍛  GPU";
          }
          {
            type = "os";
            key = "  OS";
          }
          {
            type = "kernel";
            key = "󰌽  Kernel";
          }
          {
            type = "uptime";
            key = "󱑌  Uptime";
          }
          {
            type = "packages";
            key = "󰏖  Packages";
          }
          {
            type = "memory";
            key = "󰘚  Memory";
            percentType = 3;
          }
          {
            type = "disk";
            key = "󰋊  Disk (/)";
            folders = "/";
            percentType = 3;
          }
          "break"
          {
            type = "custom";
            format = "| 󰊧 SOFTWARE";
          }
          {
            type = "wm";
            key = "󱂬  WM";
          }
          {
            type = "shell";
            key = "󰆍  Shell";
          }
          {
            type = "terminal";
            key = "󰽙  Terminal";
          }
          {
            type = "theme";
            key = "󰏘  Theme";
          }
          {
            type = "icons";
            key = "󰀻  Icons";
          }
          {
            type = "cursor";
            key = "󰆿  Cursor";
          }
          "break"
          {
            type = "custom";
            format = "| 󰊧 SIGNAL";
          }
          {
            type = "command";
            key = "󰑓  rebuild";
            shell = "/run/current-system/sw/bin/date -r /run/current-system +'rebuilt %b %d'";
          }
          "break"
          {
            type = "custom";
            format = "| 󰊧 NOW PLAYING";
          }
          {
            type = "media";
            key = "󰎵  title";
            format = "{title}";
          }
          {
            type = "media";
            key = "󰠃  artist";
            format = "{artist}";
          }
          {
            type = "media";
            key = "󰀅  album";
            format = "{album}";
          }
        ];
      };
    };
  };
}
