{
  lib,
  inputs,
  pkgs,
  vars,
  config,
  ...
}:
{
  options = {
    bars.hyprpanel.enable = lib.mkEnableOption "Enable Hyprpanel bar";
  };
  config = lib.mkIf config.bars.hyprpanel.enable {
    programs.hyprpanel = {
      enable = true;
      systemd.enable = true;
      package = pkgs.hyprpanel;
      settings = {
        bar.layouts = {
          "*" = {
            left = [
              "dashboard"
              "workspaces"
            ];
            middle = [
              "media"
              "network"
            ]
            ++ (if !vars.isDesktop then [ "battery" ] else [ "" ]);
            right = [
              "volume"
              "bluetooth"
              "systray"
              "clock"
              "notifications"
            ];
          };
        };
        wallpaper = {
          enable = false;
          pywal = true;
          image = "${vars.wallpaper}";
        };
        scalingPriority = "hyprland";
        bar = {
          launcher.autoDetectIcon = true;
          workspaces = {
            show_numbered = true;
            show_icons = false;
          };
          windowtitle = {
            class_name = false;
            custom_title = false;
            truncation_size = 35;
          };
          notifications.show_total = true;
        };
        menus = {
          clock = {
            time = {
              military = true;
              hideSeconds = true;
            };
            weather.unit = "metric";
          };
          dashboard = {
            directories.enabled = false;
            stats.enable_gpu = true;
          };
        };
        theme = {
          matugen = true;
          matugen_settings.mode = "dark";
          osd.radius = "0.7em";
          bar = {
            transparent = true;
            border_radius = "1.5em";
            floating = false;
            buttons = {
              radius = "1em";
              workspaces.pill.radius = "2.5rem * 0.7";
            };
            menus = {
              border.radius = "1em";
              card_radius = "1em";
              popover.radius = "1em";
              progressbar.radius = "1em";
            };
          };
          font = {
            name = "Hack Nerd Font";
            size = "16px";
          };
        };
      };
    };
  };
}