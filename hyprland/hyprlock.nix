{
  lib,
  config,
  vars,
  ...
}:
{
  options = {
    hyprlock.enable = lib.mkEnableOption "Enable hyprlock module";
  };
  config = lib.mkIf config.hyprlock.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = true;
          ignore_empty_input = true;
        };
        animations = {
          enabled = true;
          fade_in = {
            duration = 300;
            bezier = "easeOutQuint";
          };
          fade_out = {
            duration = 300;
            bezier = "easeOutQuint";
          };
        };

        background = [
          {
            path = "${vars.wallpaper}";
            blur_passes = 3;
            blur_size = 8;
          }
        ];
        input_field = [
          {
            size = "200, 50";
            position = "0, -80";
            monitor = "${vars.mainMonitor.name}";
            dots_center = true;
            fade_on_empty = false;
            font_color = "rgb(202, 211, 245)";
            inner_color = "rgb(91, 96, 120)";
            outer_color = "rgb(24, 25, 38)";
            outline_thickness = 5;
            placeholder_text = "Password";
            shadow_passes = 2;
          }
        ];
      };
    };
  };
}