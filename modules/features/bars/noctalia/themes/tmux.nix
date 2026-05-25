{
  lib,
  pkgs,
  config,
  ...
}:
let
  generator = pkgs.writeShellApplication {
    name = "generate-tmux-theme";
    runtimeInputs = [ pkgs.jq ];
    text = ''
      colors="$HOME/.config/noctalia/colors.json"

      [ -f "$colors" ] || exit 0
      tmux info &>/dev/null 2>&1 || exit 0

      text=$(jq -r '.mOnSurface' "$colors")
      bg_bar=$(jq -r '.mSurfaceVariant' "$colors")
      bg_pane=$(jq -r '.mSurface' "$colors")
      highlight=$(jq -r '.mPrimary' "$colors")
      selection=$(jq -r '.mSurfaceVariant' "$colors")
      info=$(jq -r '.mTertiary' "$colors")
      accent=$(jq -r '.mSecondary' "$colors")
      notice=$(jq -r '.mHover' "$colors")
      error=$(jq -r '.mError' "$colors")
      muted=$(jq -r '.mOnSurfaceVariant' "$colors")
      alert=$(jq -r '.mHover' "$colors")

      tmux set-option -gq @ukiyo-color-text "$text"
      tmux set-option -gq @ukiyo-color-bg-bar "$bg_bar"
      tmux set-option -gq @ukiyo-color-bg-pane "$bg_pane"
      tmux set-option -gq @ukiyo-color-highlight "$highlight"
      tmux set-option -gq @ukiyo-color-selection "$selection"
      tmux set-option -gq @ukiyo-color-info "$info"
      tmux set-option -gq @ukiyo-color-accent "$accent"
      tmux set-option -gq @ukiyo-color-notice "$notice"
      tmux set-option -gq @ukiyo-color-error "$error"
      tmux set-option -gq @ukiyo-color-muted "$muted"
      tmux set-option -gq @ukiyo-color-alert "$alert"

      ukiyo_root=$(tmux show-environment -g @ukiyo-root 2>/dev/null | cut -d= -f2-)
      [ -n "$ukiyo_root" ] && bash "$ukiyo_root/scripts/ukiyo.sh"
    '';
  };
in
{
  options.bars.noctalia.themes.tmux.enable = lib.mkEnableOption "tmux noctalia theme" // {
    default = true;
  };

  config = lib.mkIf (config.bars.noctalia.enable && config.bars.noctalia.themes.tmux.enable) {
    bars.noctalia.themeGenerators = [ generator ];

    home.activation.seedTmuxTheme = lib.hm.dag.entryAfter [ "unlockNoctaliaColors" ] ''
      ${generator}/bin/generate-tmux-theme || true
    '';
  };
}
