{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
let
  t = osConfig.host.themeData.ghostty;
  defaultTheme = pkgs.writeText "ghostty-noctalia-default" ''
    ${lib.concatMapStringsSep "\n" (p: "palette = ${p}") t.palette}
    background = ${t.background}
    foreground = ${t.foreground}
    cursor-color = ${t.cursorColor}
    cursor-text = ${t.background}
    selection-background = ${t.selectionBackground}
    selection-foreground = ${t.selectionForeground}
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
        font-family = "Maple Mono NF";
        background-opacity = 0.9;
        shell-integration-features = "ssh-env,ssh-terminfo";
        window-decoration = false;
        theme = "noctalia";
      };
    };
  };
}
