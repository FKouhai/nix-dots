{
  lib,
  pkgs,
  config,
  ...
}:
let
  generator = pkgs.writeShellApplication {
    name = "generate-k9s-theme";
    runtimeInputs = [ pkgs.jq ];
    text = ''
      colors="$HOME/.config/noctalia/colors.json"
      out="$HOME/.config/k9s/skins/noctalia.yaml"

      [ -f "$colors" ] || exit 0

      surface=$(jq -r '.mSurface' "$colors")
      surface_variant=$(jq -r '.mSurfaceVariant' "$colors")
      on_surface=$(jq -r '.mOnSurface' "$colors")
      on_surface_variant=$(jq -r '.mOnSurfaceVariant' "$colors")
      primary=$(jq -r '.mPrimary' "$colors")
      secondary=$(jq -r '.mSecondary' "$colors")
      tertiary=$(jq -r '.mTertiary' "$colors")
      error=$(jq -r '.mError' "$colors")

      mkdir -p "$(dirname "$out")"

      cat > "$out" << EOF
# K9s Noctalia skin - auto-generated from wallpaper colors
foreground: &foreground "$on_surface"
background: &background "$surface"
current_line: &current_line "$surface_variant"
selection: &selection "$surface_variant"
comment: &comment "$on_surface_variant"
cyan: &cyan "$tertiary"
green: &green "$tertiary"
orange: &orange "$secondary"
magenta: &magenta "$secondary"
blue: &blue "$primary"
red: &red "$error"

k9s:
  body:
    fgColor: *foreground
    bgColor: *background
    logoColor: *blue
  prompt:
    fgColor: *foreground
    bgColor: *background
    suggestColor: *orange
  info:
    fgColor: *magenta
    sectionColor: *foreground
  dialog:
    fgColor: *foreground
    bgColor: *background
    buttonFgColor: *foreground
    buttonBgColor: *magenta
    buttonFocusFgColor: *background
    buttonFocusBgColor: *cyan
    labelFgColor: *orange
    fieldFgColor: *foreground
  frame:
    border:
      fgColor: *selection
      focusColor: *current_line
    menu:
      fgColor: *foreground
      keyColor: *magenta
      numKeyColor: *magenta
    crumbs:
      fgColor: *foreground
      bgColor: *current_line
      activeColor: *current_line
    status:
      newColor: *cyan
      modifyColor: *blue
      addColor: *green
      errorColor: *red
      highlightColor: *orange
      killColor: *comment
      completedColor: *comment
    title:
      fgColor: *foreground
      bgColor: *current_line
      highlightColor: *orange
      counterColor: *blue
      filterColor: *magenta
  views:
    charts:
      bgColor: default
      defaultDialColors:
        - *blue
        - *red
      defaultChartColors:
        - *blue
        - *red
    table:
      fgColor: *foreground
      bgColor: *background
      cursorFgColor: *selection
      cursorBgColor: *current_line
      header:
        fgColor: *foreground
        bgColor: *background
        sorterColor: *cyan
    xray:
      fgColor: *foreground
      bgColor: *background
      cursorColor: *current_line
      graphicColor: *blue
      showIcons: false
    yaml:
      keyColor: *magenta
      colonColor: *blue
      valueColor: *foreground
    logs:
      fgColor: *foreground
      bgColor: *background
      indicator:
        fgColor: *foreground
        bgColor: *selection
        toggleOnColor: *magenta
        toggleOffColor: *blue
EOF
    '';
  };
in
{
  options.bars.noctalia.themes.k9s.enable = lib.mkEnableOption "k9s noctalia theme" // {
    default = true;
  };

  config = lib.mkIf (config.bars.noctalia.enable && config.bars.noctalia.themes.k9s.enable) {
    bars.noctalia.themeGenerators = [ generator ];

    home.activation.seedK9sTheme = lib.hm.dag.entryAfter [ "unlockNoctaliaColors" ] ''
      ${generator}/bin/generate-k9s-theme || true
    '';

    stylix.targets.k9s.enable = lib.mkForce false;
    programs.k9s.settings.k9s.ui.skin = lib.mkForce "noctalia";
  };
}
