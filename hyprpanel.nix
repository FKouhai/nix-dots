{
  inputs,
  pkgs,
  vars,
  ...
}:
{
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
        #name = "gruvbox_split";
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
  programs.wlogout = {
    enable = true;
    style = ''
      @define-color fg #c8d3f5;
      @define-color fg1 #a9b1d6; /* Night fg_dark */
      @define-color fg2 #c0caf5; /* Night fg */

      @define-color bg #222436;
      @define-color bg1 #444a73; /* terminal_black */
      @define-color bg2 #828bb8; /* fg_dark */
      @define-color bg3 #1a1b26; /* Night bg */

      @define-color sel #2d3f76;

      @define-color red #db4b4b; /* Night red1 */
      @define-color red1 #c53b53;

      @define-color green #c3e88d;
      @define-color green1 #76946A; /* Kanagawa autumnGreen */

      @define-color blue0 #3e68d7;
      @define-color blue #82aaff;

      @define-color cyan #86e1fc;
      window {
        font-family: JetBrainsMono Nerd Font;
        font-size: 16pt;
        color: @fg;
        background: transparent;
      }

      button {
          background-color: @bg;
          border-color: @bg;
          border-bottom-color: @bg2;

          border-radius: 10px;
          border-bottom-width: 5px;
          border-bottom-style: solid;

          /* Margin between buttons */
          margin: 5px;

          transition:
              box-shadow 0.2s ease-in-out,
              background-color 0.2s ease-in-out;

          /*  icon */
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
      }

      button:hover {
          border-color: @yellow;

          font-size: 18pt;
          font-weight: bold;
          background-size: 26%;
      }
    '';
  };
}
