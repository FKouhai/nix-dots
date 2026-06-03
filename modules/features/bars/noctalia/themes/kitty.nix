{
  lib,
  pkgs,
  config,
  ...
}:
let
  generator = pkgs.writeShellApplication {
    name = "generate-kitty-theme";
    runtimeInputs = [ pkgs.jq ];
    text = ''
      colors="$HOME/.config/noctalia/colors.json"
      out="$HOME/.config/kitty/current-theme.conf"

      [ -f "$colors" ] || exit 0

      t0=$(jq -r '.t0' "$colors")
      t1=$(jq -r '.t1' "$colors")
      t2=$(jq -r '.t2' "$colors")
      t3=$(jq -r '.t3' "$colors")
      t4=$(jq -r '.t4' "$colors")
      t5=$(jq -r '.t5' "$colors")
      t6=$(jq -r '.t6' "$colors")
      t7=$(jq -r '.t7' "$colors")
      t8=$(jq -r '.t8' "$colors")
      t9=$(jq -r '.t9' "$colors")
      t10=$(jq -r '.t10' "$colors")
      t11=$(jq -r '.t11' "$colors")
      t12=$(jq -r '.t12' "$colors")
      t13=$(jq -r '.t13' "$colors")
      t14=$(jq -r '.t14' "$colors")
      t15=$(jq -r '.t15' "$colors")
      bg=$(jq -r '.tBg' "$colors")
      fg=$(jq -r '.tFg' "$colors")
      cursor=$(jq -r '.tCursor' "$colors")
      sel_bg=$(jq -r '.tSelBg' "$colors")
      sel_fg=$(jq -r '.tSelFg' "$colors")

      mkdir -p "$(dirname "$out")"

      cat > "$out" << EOF
color0  $t0
color1  $t1
color2  $t2
color3  $t3
color4  $t4
color5  $t5
color6  $t6
color7  $t7
color8  $t8
color9  $t9
color10 $t10
color11 $t11
color12 $t12
color13 $t13
color14 $t14
color15 $t15
cursor                $cursor
cursor_text_color     $bg
background            $bg
foreground            $fg
selection_foreground  $sel_fg
selection_background  $sel_bg
active_border_color   $t4
inactive_border_color $t8
url_color             $t6
active_tab_foreground   $bg
active_tab_background   $t4
inactive_tab_foreground $sel_fg
inactive_tab_background $t8
cursor_trail_color      $sel_fg
EOF
    '';
  };
in
{
  options.bars.noctalia.themes.kitty.enable = lib.mkEnableOption "kitty noctalia theme" // {
    default = true;
  };

  config = lib.mkIf (config.bars.noctalia.enable && config.bars.noctalia.themes.kitty.enable) {
    bars.noctalia.themeGenerators = [ generator ];

    programs.noctalia.settings.theme.templates.kitty = lib.mkForce false;

    home.activation.seedKittyTheme = lib.hm.dag.entryAfter [ "unlockNoctaliaColors" ] ''
      ${generator}/bin/generate-kitty-theme || true
    '';
  };
}
