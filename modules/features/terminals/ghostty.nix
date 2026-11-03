{
  lib,
  config,
  ...
}:
let
  kanoxo = import ./kanoxo-palettes.nix;
  variant = config.terminals.variant;

  mkGhosttyTheme = p: ''
    background = ${p.bg}
    foreground = ${p.fg}
    cursor-color = ${p.fg}
    cursor-text = ${p.bg}
    selection-background = ${p.bg_sel}
    selection-foreground = ${p.fg}
    ${lib.concatStringsSep "\n" (
      lib.imap0 (i: c: "palette = ${toString i}=${c}") (kanoxo.termColors p)
    )}
  '';
in
{
  options.ghostty.enable = lib.mkEnableOption "Enable ghostty terminal";

  config = lib.mkIf config.ghostty.enable {
    xdg.configFile = {
      "ghostty/themes/kanoxo-dragon".text = mkGhosttyTheme kanoxo.palettes.dragon;
      "ghostty/themes/kanoxo-wave".text = mkGhosttyTheme kanoxo.palettes.wave;
    };

    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        font-family = "Hack Nerd Font";
        background-opacity = 0.9;
        shell-integration-features = "ssh-env,ssh-terminfo";
        window-decoration = false;
        theme = "kanoxo-${variant}";
      };
    };
  };
}
