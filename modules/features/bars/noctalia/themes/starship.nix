{
  lib,
  pkgs,
  config,
  ...
}:
let
  generator = pkgs.writeShellApplication {
    name = "generate-starship-theme";
    runtimeInputs = [ pkgs.jq ];
    text = ''
      colors="$HOME/.config/noctalia/colors.json"
      out="$HOME/.config/starship.toml"

      [ -f "$colors" ] || exit 0

      primary=$(jq -r '.mPrimary' "$colors")
      error=$(jq -r '.mError' "$colors")
      on_surface_variant=$(jq -r '.mOnSurfaceVariant' "$colors")
      secondary=$(jq -r '.mSecondary' "$colors")

      cat > "$out" << EOF
scan_timeout = 10
add_newline = false
format = """
\$symbol[ ](bold $primary)\$username\$git_branch\$kubernetes
\$directory\$character"""
right_format = "\$cmd_duration\$time\$nix_shell"

[line_break]
disabled = false

[character]
success_symbol = "[󰅂 ](bold $primary)"
error_symbol = "[󰅂 ](bold $error)"
vicmd_symbol = "[< ](bold $primary)"

[username]
show_always = true
style_user = "bold bg:none fg:$primary"
format = "[\$user](\$style)"

[hostname]
disabled = true
ssh_only = false
style = "bold bg:none fg:$primary"
format = "@[\$hostname](\$style) "

[directory]
read_only = " r"
truncation_length = 3
truncation_symbol = "./"
style = "bold bg:none fg:$primary"

[git_branch]
format = " on [\$symbol\$branch(:\$remote_branch)](\$style) "
symbol = " "
style = "bold $primary"

[time]
disabled = false
use_12hr = true
time_range = "-"
time_format = "%R"
utc_time_offset = "local"
format = "[ \$time 󰥔](\$style) "
style = "bold $secondary"

[nix_shell]
disabled = false
heuristic = false
impure_msg = "[impure-shell](red)"
pure_msg = "[pure-shell](green)"
unknown_msg = "[unknown-shell](yellow)"

[kubernetes]
disabled = false
format = "[\$symbol\$context( (\$namespace))](\$style) in "
style = "bold $on_surface_variant"
symbol = "󱃾 "

[cmd_duration]
min_time = 2000
show_milliseconds = false
format = "took [\$duration](\$style)"
style = "bold $secondary"
disabled = false
EOF
    '';
  };
in
{
  options.bars.noctalia.themes.starship.enable = lib.mkEnableOption "starship noctalia theme" // {
    default = true;
  };

  config = lib.mkIf (config.bars.noctalia.enable && config.bars.noctalia.themes.starship.enable) {
    bars.noctalia.themeGenerators = [ generator ];

    home.activation.seedStarshipTheme = lib.hm.dag.entryAfter [ "unlockNoctaliaColors" ] ''
      ${generator}/bin/generate-starship-theme || true
    '';
  };
}
