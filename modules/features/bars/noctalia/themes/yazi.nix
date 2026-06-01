{
  lib,
  pkgs,
  config,
  ...
}:
let
  generator = pkgs.writeShellApplication {
    name = "generate-yazi-theme";
    runtimeInputs = [ pkgs.jq ];
    text = ''
      colors="$HOME/.config/noctalia/colors.json"
      out="$HOME/.config/yazi/theme.toml"

      [ -f "$colors" ] || exit 0

      primary=$(jq -r '.mPrimary' "$colors")
      secondary=$(jq -r '.mSecondary' "$colors")
      tertiary=$(jq -r '.mTertiary' "$colors")
      error=$(jq -r '.mError' "$colors")
      green=$(jq -r '.mGreen' "$colors")
      yellow=$(jq -r '.mYellow' "$colors")
      orange=$(jq -r '.mOrange' "$colors")
      outline=$(jq -r '.mOutline' "$colors")
      surface_variant=$(jq -r '.mSurfaceVariant' "$colors")
      sel_bg=$(jq -r '.tSelBg' "$colors")
      on_surface=$(jq -r '.mOnSurface' "$colors")
      on_surface_variant=$(jq -r '.mOnSurfaceVariant' "$colors")
      bg=$(jq -r '.tBg' "$colors")

      mkdir -p "$(dirname "$out")"

      cat > "$out" << EOF
[mgr]
cwd              = { fg = "$primary" }
find_keyword     = { fg = "$green", bold = true }
find_position    = { fg = "$secondary" }
marker_selected  = { fg = "$yellow",  bg = "$yellow" }
marker_copied    = { fg = "$green",   bg = "$green" }
marker_cut       = { fg = "$error",   bg = "$error" }
border_style     = { fg = "$outline" }
count_selected   = { fg = "$bg", bg = "$yellow" }
count_copied     = { fg = "$bg", bg = "$green" }
count_cut        = { fg = "$bg", bg = "$error" }

[indicator]
current = { bg = "$sel_bg", bold = true }
preview = { bg = "$sel_bg", bold = true }

[tabs]
active   = { fg = "$bg",      bg = "$primary", bold = true }
inactive = { fg = "$primary", bg = "$surface_variant" }

[mode]
normal_main = { fg = "$bg",      bg = "$primary", bold = true }
normal_alt  = { fg = "$primary", bg = "$bg" }
select_main = { fg = "$bg",      bg = "$green",   bold = true }
select_alt  = { fg = "$green",   bg = "$bg" }
unset_main  = { fg = "$bg",      bg = "$orange",  bold = true }
unset_alt   = { fg = "$orange",  bg = "$bg" }

[status]
progress_label  = { fg = "$on_surface",  bg = "$bg" }
progress_normal = { fg = "$on_surface",  bg = "$bg" }
progress_error  = { fg = "$error",       bg = "$bg" }
perm_type       = { fg = "$primary" }
perm_read       = { fg = "$yellow" }
perm_write      = { fg = "$error" }
perm_exec       = { fg = "$green" }
perm_sep        = { fg = "$tertiary" }

[pick]
border   = { fg = "$primary" }
active   = { fg = "$secondary" }
inactive = { fg = "$on_surface" }

[input]
border   = { fg = "$primary" }
title    = { fg = "$on_surface" }
value    = { fg = "$on_surface" }
selected = { bg = "$outline" }

[completion]
border   = { fg = "$primary" }
active   = { fg = "$secondary", bg = "$outline" }
inactive = { fg = "$on_surface" }

[tasks]
border  = { fg = "$primary" }
title   = { fg = "$on_surface" }
hovered = { fg = "$on_surface", bg = "$outline" }

[which]
mask             = { bg = "$surface_variant" }
cand             = { fg = "$tertiary" }
rest             = { fg = "$orange" }
desc             = { fg = "$on_surface" }
separator_style  = { fg = "$on_surface_variant" }

[help]
on      = { fg = "$secondary" }
run     = { fg = "$tertiary" }
desc    = { fg = "$on_surface" }
hovered = { fg = "$on_surface", bg = "$outline" }
footer  = { fg = "$on_surface" }

[[filetype.rules]]
mime = "image/*"
fg = "$tertiary"

[[filetype.rules]]
mime = "video/*"
fg = "$yellow"

[[filetype.rules]]
mime = "audio/*"
fg = "$yellow"

[[filetype.rules]]
mime = "application/zip"
fg = "$secondary"

[[filetype.rules]]
mime = "application/gzip"
fg = "$secondary"

[[filetype.rules]]
mime = "application/tar"
fg = "$secondary"

[[filetype.rules]]
mime = "application/bzip2"
fg = "$secondary"

[[filetype.rules]]
mime = "application/7z-compressed"
fg = "$secondary"

[[filetype.rules]]
mime = "application/rar"
fg = "$secondary"

[[filetype.rules]]
mime = "application/xz"
fg = "$secondary"

[[filetype.rules]]
mime = "application/pdf"
fg = "$green"

[[filetype.rules]]
mime = "application/vnd.*"
fg = "$green"

[[filetype.rules]]
url = "*/"
fg = "$primary"
bold = true

[[filetype.rules]]
mime = "*"
fg = "$on_surface"
EOF
    '';
  };
in
{
  options.bars.noctalia.themes.yazi.enable = lib.mkEnableOption "yazi noctalia theme" // {
    default = true;
  };

  config = lib.mkIf (config.bars.noctalia.enable && config.bars.noctalia.themes.yazi.enable) {
    bars.noctalia.themeGenerators = [ generator ];

    home.activation.seedYaziTheme = lib.hm.dag.entryAfter [ "unlockNoctaliaColors" ] ''
      ${generator}/bin/generate-yazi-theme || true
    '';
  };
}
