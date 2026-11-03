{
  lib,
  config,
  ...
}:
let
  kanoxo = import ./kanoxo-palettes.nix;
  variant = config.terminals.variant;

  mkKittyTheme = p: ''
    background            ${p.bg}
    foreground            ${p.fg}
    cursor                ${p.fg}
    cursor_text_color     ${p.bg}
    selection_background  ${p.bg_sel}
    selection_foreground  ${p.fg}
    ${lib.concatStringsSep "\n" (lib.imap0 (i: c: "color${toString i}  ${c}") (kanoxo.termColors p))}
    active_border_color   ${p.blue}
    inactive_border_color ${p.border}
    url_color             ${p.teal}
    active_tab_foreground   ${p.bg}
    active_tab_background   ${p.blue}
    inactive_tab_foreground ${p.fg}
    inactive_tab_background ${p.bg_sel}
  '';
in
{
  options = {
    kitty.enable = lib.mkEnableOption "Enable kitty module";
  };
  config = lib.mkIf config.kitty.enable {
    # Kitty uses static kanoxo themes now; disable the Noctalia wallpaper-driven
    # generator (same pattern as stylix target overrides in bars/noctalia/themes).
    bars.noctalia.themes.kitty.enable = lib.mkForce false;

    xdg.configFile = {
      "kitty/themes/kanoxo-dragon.conf".text = mkKittyTheme kanoxo.palettes.dragon;
      "kitty/themes/kanoxo-wave.conf".text = mkKittyTheme kanoxo.palettes.wave;
    };

    programs.kitty = {
      enable = true;
      settings = {
        font_family = "Hack Nerd Font";
        bold_font = "auto";
        italic_font = "auto";
        background_opacity = 0.7;
        bold_italic_font = "auto";
        enable_audio_bell = false;
        scrollback_lines = -1;
        tab_bar_edge = "top";
        allow_remote_control = "yes";
        cursor_trail = 1;
      };
      shellIntegration = {
        enableZshIntegration = true;
      };
      extraConfig = "include themes/kanoxo-${variant}.conf";
    };
  };
}
