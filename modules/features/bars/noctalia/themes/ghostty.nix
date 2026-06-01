{
  lib,
  pkgs,
  config,
  ...
}:
let
  generator = pkgs.writeShellApplication {
    name = "generate-ghostty-theme";
    runtimeInputs = [ pkgs.jq ];
    text = ''
      colors="$HOME/.config/noctalia/colors.json"
      out="$HOME/.config/ghostty/themes/noctalia"

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
palette = 0= $t0
palette = 1= $t1
palette = 2= $t2
palette = 3= $t3
palette = 4= $t4
palette = 5= $t5
palette = 6= $t6
palette = 7= $t7
palette = 8= $t8
palette = 9= $t9
palette = 10= $t10
palette = 11= $t11
palette = 12= $t12
palette = 13= $t13
palette = 14= $t14
palette = 15= $t15
background = $bg
foreground = $fg
cursor-color = $cursor
cursor-text = $bg
selection-background = $sel_bg
selection-foreground = $sel_fg
EOF
    '';
  };
in
{
  options.bars.noctalia.themes.ghostty.enable = lib.mkEnableOption "ghostty noctalia theme" // {
    default = true;
  };

  config = lib.mkIf (config.bars.noctalia.enable && config.bars.noctalia.themes.ghostty.enable) {
    bars.noctalia.themeGenerators = [ generator ];

    programs.noctalia-shell.settings.templates.ghostty = lib.mkForce false;

    home.activation.seedGhosttyTheme = lib.hm.dag.entryAfter [ "unlockNoctaliaColors" ] ''
      ${generator}/bin/generate-ghostty-theme || true
    '';
  };
}
