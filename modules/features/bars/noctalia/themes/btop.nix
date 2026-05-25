{
  lib,
  pkgs,
  config,
  ...
}:
let
  generator = pkgs.writeShellApplication {
    name = "generate-btop-theme";
    runtimeInputs = [ pkgs.jq ];
    text = ''
      colors="$HOME/.config/noctalia/colors.json"
      out="$HOME/.config/btop/themes/noctalia.theme"

      [ -f "$colors" ] || exit 0

      surface=$(jq -r '.mSurface' "$colors")
      surface_variant=$(jq -r '.mSurfaceVariant' "$colors")
      on_surface=$(jq -r '.mOnSurface' "$colors")
      on_surface_variant=$(jq -r '.mOnSurfaceVariant' "$colors")
      outline=$(jq -r '.mOutline' "$colors")
      primary=$(jq -r '.mPrimary' "$colors")
      secondary=$(jq -r '.mSecondary' "$colors")
      tertiary=$(jq -r '.mTertiary' "$colors")
      error=$(jq -r '.mError' "$colors")

      mkdir -p "$(dirname "$out")"

      cat > "$out" << EOF
# Noctalia btop theme - auto-generated from wallpaper colors
theme[main_bg]=$surface
theme[main_fg]=$on_surface
theme[title]=$on_surface
theme[hi_fg]=$primary
theme[selected_bg]=$surface_variant
theme[selected_fg]=$on_surface
theme[inactive_fg]=$on_surface_variant
theme[graph_text]=$on_surface
theme[meter_bg]=$outline
theme[proc_misc]=$on_surface
theme[cpu_box]=$primary
theme[mem_box]=$tertiary
theme[net_box]=$secondary
theme[proc_box]=$primary
theme[div_line]=$outline
theme[temp_start]=$tertiary
theme[temp_mid]=$on_surface_variant
theme[temp_end]=$error
theme[cpu_start]=$primary
theme[cpu_mid]=$on_surface_variant
theme[cpu_end]=$secondary
theme[free_start]=$tertiary
theme[free_mid]=
theme[free_end]=$tertiary
theme[cached_start]=$secondary
theme[cached_mid]=
theme[cached_end]=$secondary
theme[available_start]=$on_surface_variant
theme[available_mid]=$outline
theme[available_end]=$surface_variant
theme[used_start]=$error
theme[used_mid]=
theme[used_end]=$error
theme[download_start]=$secondary
theme[download_mid]=
theme[download_end]=$secondary
theme[upload_start]=$tertiary
theme[upload_mid]=
theme[upload_end]=$tertiary
theme[process_start]=$primary
theme[process_mid]=$secondary
theme[process_end]=$tertiary
EOF
    '';
  };
in
{
  options.bars.noctalia.themes.btop.enable = lib.mkEnableOption "btop noctalia theme" // {
    default = true;
  };

  config = lib.mkIf (config.bars.noctalia.enable && config.bars.noctalia.themes.btop.enable) {
    bars.noctalia.themeGenerators = [ generator ];

    home.activation.seedBtopTheme = lib.hm.dag.entryAfter [ "unlockNoctaliaColors" ] ''
      ${generator}/bin/generate-btop-theme || true
    '';

    stylix.targets.btop.enable = lib.mkForce false;
    programs.btop.settings.color_theme = lib.mkForce "noctalia";
  };
}
