{
  lib,
  config,
  ...
}:
{
  options = {
    kitty.enable = lib.mkEnableOption "Enable kitty module";
  };
  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      settings = {
        font_family = "Maple Mono NF";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        enable_audio_bell = false;
        scrollback_lines = -1;
        tab_bar_edge = "top";
        allow_remote_control = "yes";
      };
      shellIntegration = {
        enableZshIntegration = true;
      };
      themeFile = "kanagawa";
    };
  };
}
