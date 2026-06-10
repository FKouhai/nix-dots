{
  lib,
  config,
  inputs,
  ...
}:
{
  config = lib.mkIf config.bars.noctalia.enable {
    programs.noctalia = {
      systemd.enable = true;
      enable = true;
      settings = {
        launch_apps_as_systemd_services = true;
        shell = {
          font_family = lib.mkForce "Hack Nerd Font";
          ui_scale = 1.0;
          corner_radius_scale = 1.0;
          clipboard_enabled = true;
          clipboard_history_max_entries = 50;
          clipboard_auto_paste = "auto";
          middle_click_opens_widget_settings = true;
          telemetry_enabled = false;
          shared_gl_context = true;
          show_location = true;
          animation = {
            enabled = true;
            speed = 1.0;
          };
          panel = {
            transparency_mode = "solid";
            borders = true;
            shadow = true;
            launcher_placement = "centered";
            clipboard_placement = "centered";
            control_center_placement = "floating";
            wallpaper_placement = "centered";
            session_placement = "centered";
            open_near_click_control_center = false;
            open_near_click_launcher = false;
            open_near_click_clipboard = false;
            open_near_click_wallpaper = false;
            open_near_click_session = false;
          };
          shadow = {
            direction = "down";
            alpha = 0.55;
          };
        };

        launcher = {
          terminal_command = "ghostty -e";
        };

        audio = {
          enable_overdrive = false;
          enable_sounds = false;
          sound_volume = 0.5;
        };

        notification = {
          enable_daemon = true;
          position = "top_right";
          background_opacity = 0.97;
          show_app_name = true;
          show_actions = true;
          layer = "top";
          offset_x = 20;
          offset_y = 8;
          scale = 1.0;
        };

        osd = {
          position = "top_center";
          orientation = "horizontal";
          background_opacity = 0.97;
          offset_x = 20;
          offset_y = 8;
          scale = 1.0;
          lock_keys = true;
          keyboard_layout = true;
        };

        location = {
          address = "Madrid";
          auto_locate = false;
        };

        wallpaper = {
          directory = "${inputs.wallpapers}";
          enabled = true;
          fill_mode = "crop";
          transition_duration = 1500;
          transition = [
            "fade"
            "wipe"
            "disc"
            "stripes"
            "zoom"
            "honeycomb"
          ];
          edge_smoothness = 0.3;
          transition_on_startup = false;
        };

        theme = {
          wallpaper_scheme = "m3-tonal-spot";
          templates = {
            builtin_ids = [
              "btop"
              "gtk3"
              "gtk4"
              "ghostty"
              "hyprland"
              "kitty"
              "qt"
              "starship"
            ];
            community_ids = [
              "pywalfox"
              "discord"
              "telegram"
              "yazi"
            ];
          };
        };

        lockscreen = {
          blurred_desktop = false;
          blur_intensity = 0.5;
          tint_intensity = 0.3;
        };

        lockscreen_widgets = {
          enabled = true;
          schema_version = 1;
          widget_order = [
            "lockscreen-widget-0000000000000001"
            "lockscreen-widget-0000000000000003"
            "lockscreen-login-box@HDMI-A-1"
            "lockscreen-login-box@DP-2"
            "lockscreen-widget-0000000000000004"
            "lockscreen-widget-0000000000000005"
            "lockscreen-widget-0000000000000006"
            "lockscreen-widget-0000000000000007"
            "lockscreen-widget-0000000000000008"
            "lockscreen-widget-0000000000000009"
            "lockscreen-widget-000000000000000a"
            "lockscreen-widget-000000000000000b"
            "lockscreen-widget-000000000000000c"
          ];
          grid = {
            cell_size = 16;
            major_interval = 4;
            visible = true;
          };
          widget = {
            "lockscreen-login-box@DP-2" = {
              cx = 1280.0;
              cy = 1317.0;
              output = "DP-2";
              rotation = 0.0;
              scale = 1.0;
              type = "login_box";
            };
            "lockscreen-login-box@HDMI-A-1" = {
              cx = 1280.0;
              cy = 1317.0;
              output = "HDMI-A-1";
              rotation = 0.0;
              scale = 1.0;
              type = "login_box";
            };
            "lockscreen-widget-0000000000000001" = {
              cx = 1280.0;
              cy = 580.5;
              output = "HDMI-A-1";
              rotation = 0.0;
              scale = 4.2353177070617676;
              type = "clock";
              settings = {
                background_opacity = 0.0;
              };
            };
            "lockscreen-widget-0000000000000003" = {
              cx = 1455.969482421875;
              cy = 832.0;
              output = "HDMI-A-1";
              rotation = 0.0;
              scale = 1.7782632112503052;
              type = "media_player";
              settings = {
                background = false;
                background_opacity = 0.0;
                background_padding = 0.0;
                background_radius = 32.0;
                hide_when_no_media = true;
                layout = "horizontal";
                shadow = true;
              };
            };
            "lockscreen-widget-0000000000000004" = {
              cx = 1012.0;
              cy = 770.0;
              output = "HDMI-A-1";
              rotation = 0.0;
              scale = 1.0;
              type = "weather";
              settings = {
                background = false;
                background_opacity = 0.0;
              };
            };
            "lockscreen-widget-0000000000000005" = {
              cx = 1020.0;
              cy = 884.5;
              output = "HDMI-A-1";
              rotation = 0.0;
              scale = 1.0;
              type = "sysmon";
              settings = {
                background = false;
                shadow = false;
                show_label = true;
                stat = "cpu_temp";
                stat2 = "";
              };
            };
            "lockscreen-widget-0000000000000006" = {
              cx = 1280.0;
              cy = 544.0;
              output = "DP-2";
              rotation = 0.0;
              scale = 4.4676055908203125;
              type = "clock";
              settings = {
                background = false;
                background_opacity = 0.0;
              };
            };
            "lockscreen-widget-0000000000000007" = {
              cx = 1280.0;
              cy = 720.0;
              output = "DP-2";
              rotation = 0.0;
              scale = 1.0;
              type = "audio_visualizer";
              settings = {
                aspect_ratio = 2.5;
                background = false;
                background_opacity = 1.0;
                bands = 32;
                show_when_idle = true;
              };
            };
            "lockscreen-widget-0000000000000008" = {
              cx = 960.0;
              cy = 836.5;
              output = "DP-2";
              rotation = 0.0;
              scale = 1.0;
              type = "sysmon";
              settings = {
                background = false;
              };
            };
            "lockscreen-widget-0000000000000009" = {
              cx = 1628.0;
              cy = 846.5;
              output = "DP-2";
              rotation = 0.0;
              scale = 1.0;
              type = "sysmon";
              settings = {
                background = false;
                background_opacity = 0.66;
                stat = "net_rx";
                stat2 = "net_tx";
              };
            };
            "lockscreen-widget-000000000000000a" = {
              cx = 1404.0;
              cy = 846.5;
              output = "DP-2";
              rotation = 0.0;
              scale = 1.0;
              type = "sysmon";
              settings = {
                background = false;
                stat = "ram_pct";
              };
            };
            "lockscreen-widget-000000000000000b" = {
              cx = 1180.0;
              cy = 846.5;
              output = "DP-2";
              rotation = 0.0;
              scale = 1.0;
              type = "sysmon";
              settings = {
                background = false;
                stat = "cpu_temp";
              };
            };
            "lockscreen-widget-000000000000000c" = {
              cx = 1280.0;
              cy = 994.0;
              output = "DP-2";
              rotation = 0.0;
              scale = 1.0;
              type = "weather";
              settings = {
                background = false;
              };
            };
          };
        };

        system.monitor = {
          enabled = true;
          cpu_poll_seconds = 2.0;
          gpu_poll_seconds = 0.0;
          memory_poll_seconds = 2.0;
          network_poll_seconds = 3.0;
          disk_poll_seconds = 10.0;
        };

        weather = {
          enabled = true;
          refresh_minutes = 30;
          unit = "metric";
          effects = true;
        };

        control_center = {
          shortcuts = [
            { type = "wifi"; }
            { type = "bluetooth"; }
            { type = "caffeine"; }
            { type = "nightlight"; }
            { type = "notification"; }
            { type = "power_profile"; }
          ];
        };
      };

    };
  };
}
