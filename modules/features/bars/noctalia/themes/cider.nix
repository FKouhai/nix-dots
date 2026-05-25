{
  lib,
  pkgs,
  config,
  ...
}:
let
  generator = pkgs.writeShellApplication {
    name = "generate-cider-theme";
    runtimeInputs = [ pkgs.jq ];
    text = ''
      colors="$HOME/.config/noctalia/colors.json"
      theme_dir="$HOME/.config/sh.cider.genten/themes/kanagawa-dragon-cider"
      main_css="$theme_dir/main.css"
      out="$theme_dir/noctalia.css"
      theme_yml="$theme_dir/theme.yml"

      [ -f "$colors" ] || exit 0
      [ -f "$main_css" ] || exit 0

      surface=$(jq -r '.mSurface' "$colors")
      surface_variant=$(jq -r '.mSurfaceVariant' "$colors")
      on_surface=$(jq -r '.mOnSurface' "$colors")
      on_surface_variant=$(jq -r '.mOnSurfaceVariant' "$colors")
      outline=$(jq -r '.mOutline' "$colors")
      primary=$(jq -r '.mPrimary' "$colors")
      secondary=$(jq -r '.mSecondary' "$colors")
      tertiary=$(jq -r '.mTertiary' "$colors")
      error=$(jq -r '.mError' "$colors")

      struct_start=$(grep -n '/\* Globals \*/' "$main_css" | head -1 | cut -d: -f1)
      [ -n "$struct_start" ] || exit 1

      cat > "$out" << EOF
body.body--dark {

  --accent: $primary;
  --text: $on_surface;
  --subtext1: color-mix(in oklch, $on_surface, $surface 25%);
  --subtext0: $on_surface_variant;
  --overlay1: $error;
  --overlay0: $outline;
  --surface0: $surface_variant;
  --base: color-mix(in oklch, $surface, $surface_variant 40%);
  --mantle: color-mix(in oklch, $surface, $surface_variant 40%);
  --crust: $surface;

  --selection-bg: color-mix(in srgb, $primary, transparent 70%);
  --red: $error;
  --green: $tertiary;
  --blue: $secondary;

EOF
      tail -n +"$struct_start" "$main_css" >> "$out"

      if ! grep -q 'noctalia' "$theme_yml" 2>/dev/null; then
        cat >> "$theme_yml" << 'YAML'
  - file: noctalia.css
    name: noctalia
    description: Auto-generated theme matching current wallpaper colors
YAML
      fi
    '';
  };
in
{
  options.bars.noctalia.themes.cider.enable = lib.mkEnableOption "cider noctalia theme" // {
    default = true;
  };

  config = lib.mkIf (config.bars.noctalia.enable && config.bars.noctalia.themes.cider.enable) {
    bars.noctalia.themeGenerators = [ generator ];

    home.activation.seedCiderTheme = lib.hm.dag.entryAfter [ "unlockNoctaliaColors" ] ''
      ${generator}/bin/generate-cider-theme || true
    '';
  };
}
