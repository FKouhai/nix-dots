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
