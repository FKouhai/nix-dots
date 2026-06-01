{
  lib,
  pkgs,
  config,
  ...
}:
let
  generator = pkgs.writeShellApplication {
    name = "generate-lazygit-theme";
    runtimeInputs = [ pkgs.jq ];
    text = ''
      colors="$HOME/.config/noctalia/colors.json"
      out="$HOME/.config/lazygit/config.yml"

      [ -f "$colors" ] || exit 0

      primary=$(jq -r '.mPrimary' "$colors")
      secondary=$(jq -r '.mSecondary' "$colors")
      tertiary=$(jq -r '.mTertiary' "$colors")
      error=$(jq -r '.mError' "$colors")
      yellow=$(jq -r '.mYellow' "$colors")
      outline=$(jq -r '.mOutline' "$colors")
      surface_variant=$(jq -r '.mSurfaceVariant' "$colors")
      sel_bg=$(jq -r '.tSelBg' "$colors")
      on_surface=$(jq -r '.mOnSurface' "$colors")

      mkdir -p "$(dirname "$out")"

      cat > "$out" << EOF
gui:
  theme:
    activeBorderColor:
      - '$primary'
      - bold
    inactiveBorderColor:
      - '$outline'
    searchingActiveBorderColor:
      - '$tertiary'
      - bold
    optionsTextColor:
      - '$secondary'
    selectedLineBgColor:
      - '$sel_bg'
    inactiveViewSelectedLineBgColor:
      - '$surface_variant'
    cherryPickedCommitFgColor:
      - '$primary'
    cherryPickedCommitBgColor:
      - '$tertiary'
    markedBaseCommitFgColor:
      - '$primary'
    markedBaseCommitBgColor:
      - '$yellow'
    unstagedChangesColor:
      - '$error'
    defaultFgColor:
      - '$on_surface'
EOF
    '';
  };
in
{
  options.bars.noctalia.themes.lazygit.enable = lib.mkEnableOption "lazygit noctalia theme" // {
    default = true;
  };

  config = lib.mkIf (config.bars.noctalia.enable && config.bars.noctalia.themes.lazygit.enable) {
    bars.noctalia.themeGenerators = [ generator ];

    home.activation.seedLazygitTheme = lib.hm.dag.entryAfter [ "unlockNoctaliaColors" ] ''
      ${generator}/bin/generate-lazygit-theme || true
    '';
  };
}
