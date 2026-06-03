{
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.bars.noctalia.enable {
    programs.noctalia.settings = {
      bar.default = {
        position = "top";
        background_opacity = lib.mkForce 0.7;
        reserve_space = true;
        capsule = true;
        capsule_fill = "surface_variant";
        capsule_opacity = 1.0;
        capsule_padding = 6.0;
        radius = 16;
        margin_edge = 10;
        margin_ends = 180;
        padding = 14;
        widget_spacing = 11;
        font_weight = 500;
        shadow = true;
        scale = 1.0;
        thickness = 34;
        layer = "top";
        start = [ "launcher" "clock" "sysmon" "active_window" ];
        center = [ "workspaces" "media" ];
        end = [ "tray" "notifications" "battery" "volume" "brightness" "control-center" "clipboard" ];
      };

      widget = {
        active_window = {
          type = "active_window";
          icon_size = 14.0;
          max_length = 260.0;
          min_length = 80.0;
          title_scroll = "none";
        };
        cpu = {
          type = "sysmon";
          stat = "cpu_usage";
        };
        date = {
          type = "clock";
          format = "{:%a %d %b}";
        };
        input_volume = {
          type = "volume";
          device = "input";
        };
        keyboard_layout = {
          type = "keyboard_layout";
          cycle_command = "";
          hide_when_single_layout = false;
        };
        lock_keys = {
          type = "lock_keys";
          display = "short";
          hide_when_off = false;
          show_caps_lock = true;
          show_num_lock = true;
          show_scroll_lock = false;
        };
        media = {
          type = "media";
          art_size = 16.0;
          max_length = 220.0;
          min_length = 80.0;
          title_scroll = "none";
        };
        network_rx = {
          type = "sysmon";
          stat = "net_rx";
        };
        network_tx = {
          type = "sysmon";
          stat = "net_tx";
        };
        output_volume = {
          type = "volume";
          device = "output";
        };
        ram = {
          type = "sysmon";
          stat = "ram_used";
        };
        spacer = {
          type = "spacer";
        };
        temp = {
          type = "sysmon";
          stat = "cpu_temp";
        };
      };
    };
  };
}
