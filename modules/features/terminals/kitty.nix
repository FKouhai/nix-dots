{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
{
  options = {
    kitty.enable = lib.mkEnableOption "Enable kitty module";
  };
  config = lib.mkIf config.kitty.enable {
    # Seed current-theme.conf as an empty placeholder until Noctalia writes the real theme.
    # Noctalia's template-apply.sh will replace this with a symlink to themes/noctalia.conf.
    home.activation.kittyNoctaliaTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      themeFile="$HOME/.config/kitty/current-theme.conf"
      if [ ! -e "$themeFile" ]; then
        ${pkgs.coreutils}/bin/mkdir -p "$HOME/.config/kitty"
        ${pkgs.coreutils}/bin/touch "$themeFile"
      fi
    '';

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
      themeFile = osConfig.host.themeData.kittyTheme;
      extraConfig = "include current-theme.conf";
    };
  };
}
