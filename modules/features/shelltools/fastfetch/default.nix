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
          padding = {
            top = 2;
            left = 1;
            right = 2;
          };
        };
        display = {
          separator = "  ";
          color.keys = "cyan";
        };
        modules = [
          {
            type = "title";
            format = "{#1}╭───────────── {#}{user-name-colored}";
          }
          # Hardware
          {
            type = "custom";
            format = "{#1}│ {#}Hardware Information";
          }
          {
            type = "cpu";
            key = "{#1}│  {#keys}󰻠 CPU";
          }
          {
            type = "gpu";
            key = "{#1}│  {#keys}󰢮 GPU";
          }
          {
            type = "memory";
            key = "{#1}│  {#keys}󰍛 Memory";
            percentType = 3;
          }
          {
            type = "disk";
            key = "{#1}│  {#keys}󰋊 Disk (/)";
            folders = "/";
            percentType = 3;
          }
          {
            type = "custom";
            format = "{#1}│";
          }
          # System
          {
            type = "custom";
            format = "{#1}│ {#}System Information";
          }
          {
            type = "os";
            key = "{#1}│  {#keys}󰍹 OS";
          }
          {
            type = "kernel";
            key = "{#1}│  {#keys}󰒋 Kernel";
          }
          {
            type = "uptime";
            key = "{#1}│  {#keys}󰅐 Uptime";
          }
          {
            type = "packages";
            key = "{#1}│  {#keys}󰏖 Packages";
            format = "{all}";
          }
          {
            type = "custom";
            format = "{#1}│";
          }
          # Software
          {
            type = "custom";
            format = "{#1}│ {#}Desktop Environment";
          }
          {
            type = "wm";
            key = "{#1}│  {#keys}󱂬 WM";
          }
          {
            type = "shell";
            key = "{#1}│  {#keys}󰆍 Shell";
          }
          {
            type = "terminal";
            key = "{#1}│  {#keys}󰽙 Terminal";
          }
          {
            type = "theme";
            key = "{#1}│  {#keys}󰏘 Theme";
          }
          {
            type = "icons";
            key = "{#1}│  {#keys}󰀻 Icons";
          }
          {
            type = "cursor";
            key = "{#1}│  {#keys}󰆿 Cursor";
          }
          {
            type = "custom";
            format = "{#1}│";
          }
          # Signal
          {
            type = "custom";
            format = "{#1}│ {#}Signal";
          }
          {
            type = "command";
            key = "{#1}│  {#keys}󰑓 Rebuilt";
            shell = "/run/current-system/sw/bin/bash";
            text = "nh os info | awk '/current/ {print $3, $4}'";
          }
          {
            type = "command";
            key = "{#1}│  {#keys}󰋊 Closure";
            shell = "/run/current-system/sw/bin/bash";
            text = "nh os info | awk '/current/ {print $7, $8}'";
          }
          {
            type = "custom";
            format = "{#1}│";
          }
          # Now Playing
          {
            type = "custom";
            format = "{#1}│ {#}Now Playing";
          }
          {
            type = "media";
            key = "{#1}│  {#keys}󰎵 Title";
            format = "{title}";
          }
          {
            type = "media";
            key = "{#1}│  {#keys}󰠃 Artist";
            format = "{artist}";
          }
          {
            type = "media";
            key = "{#1}│  {#keys}󰀅 Album";
            format = "{album}";
          }
          {
            type = "custom";
            format = "{#1}│";
          }
          # Colors
          {
            type = "colors";
            key = "{#1}│";
            symbol = "circle";
          }
          # Footer
          {
            type = "custom";
            format = "{#1}╰───────────────────────────────╯";
          }
        ];
      };
    };
  };
}
