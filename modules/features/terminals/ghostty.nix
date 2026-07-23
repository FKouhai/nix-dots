{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
let
  defaultTheme = pkgs.writeText "ghostty-noctalia-default" ''
    background = #1a1b26
    foreground = #c0caf5
    palette = 0=#1a1b26
    palette = 1=#f7768e
    palette = 2=#9ece6a
    palette = 3=#e0af68
    palette = 4=#7aa2f7
    palette = 5=#bb9af7
    palette = 6=#7dcfff
    palette = 7=#a9b1d6
    palette = 8=#414868
    palette = 9=#f7768e
    palette = 10=#9ece6a
    palette = 11=#e0af68
    palette = 12=#7aa2f7
    palette = 13=#bb9af7
    palette = 14=#7dcfff
    palette = 15=#c0caf5
  '';
in
{
  options.ghostty.enable = lib.mkEnableOption "Enable ghostty terminal";

  config = lib.mkIf config.ghostty.enable {
    # Seed ~/.config/ghostty/themes/noctalia only when missing or still a Nix symlink.
    # Noctalia will overwrite this file at runtime after each wallpaper change.
    home.activation.ghosttyNoctaliaTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      themeDir="$HOME/.config/ghostty/themes"
      themeFile="$themeDir/noctalia"
      ${pkgs.coreutils}/bin/mkdir -p "$themeDir"
      if [ ! -f "$themeFile" ] || [ -L "$themeFile" ]; then
        ${pkgs.coreutils}/bin/cp ${defaultTheme} "$themeFile"
        ${pkgs.coreutils}/bin/chmod 644 "$themeFile"
      fi
    '';

    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        font-family = "Hack Nerd Font";
        background-opacity = 0.9;
        shell-integration-features = "ssh-env,ssh-terminfo";
        window-decoration = false;
        theme = "noctalia";
      };
    };
  };
}
