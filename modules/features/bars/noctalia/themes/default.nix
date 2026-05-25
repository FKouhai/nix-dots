{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:
let
  defaultNoctaliaColors =
    let
      t = osConfig.host.themeData.base16Scheme;
    in
    pkgs.writeText "noctalia-colors-default.json" (builtins.toJSON {
      mError = "#${t.base08}";
      mHover = "#${t.base0C}";
      mOnError = "#${t.base00}";
      mOnHover = "#${t.base00}";
      mOnPrimary = "#${t.base00}";
      mOnSecondary = "#${t.base00}";
      mOnSurface = "#${t.base05}";
      mOnSurfaceVariant = "#${t.base04}";
      mOnTertiary = "#${t.base00}";
      mOutline = "#${t.base03}";
      mPrimary = "#${t.base0D}";
      mSecondary = "#${t.base0E}";
      mShadow = "#${t.base00}";
      mSurface = "#${t.base00}";
      mSurfaceVariant = "#${t.base01}";
      mTertiary = "#${t.base0C}";
    });

  wallpaperHook = pkgs.writeShellScript "noctalia-wallpaper-hook" (
    lib.concatMapStrings (gen: "${gen}/bin/${gen.name} || true &\n")
      config.bars.noctalia.themeGenerators
    + "wait\n"
  );

  themeFiles = lib.filterAttrs (
    name: type: type == "regular" && name != "default.nix" && lib.hasSuffix ".nix" name
  ) (builtins.readDir ./.);
in
{
  imports = lib.mapAttrsToList (name: _: ./. + "/${name}") themeFiles;

  options.bars.noctalia.themeGenerators = lib.mkOption {
    type = lib.types.listOf lib.types.package;
    default = [ ];
    internal = true;
  };

  config = lib.mkIf config.bars.noctalia.enable {
    home.activation.unlockNoctaliaColors = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      colors="$HOME/.config/noctalia/colors.json"
      if [ -L "$colors" ]; then
        tmp=$(${pkgs.coreutils}/bin/mktemp)
        ${pkgs.coreutils}/bin/cp "$(${pkgs.coreutils}/bin/readlink "$colors")" "$tmp"
        ${pkgs.coreutils}/bin/rm "$colors"
        ${pkgs.coreutils}/bin/mv "$tmp" "$colors"
      elif [ ! -f "$colors" ]; then
        ${pkgs.coreutils}/bin/cp ${defaultNoctaliaColors} "$colors"
        ${pkgs.coreutils}/bin/chmod 644 "$colors"
      fi
    '';

    home.activation.patchNoctaliaGuiSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      guiSettings="$HOME/.config/noctalia/gui-settings.json"
      if [ -f "$guiSettings" ]; then
        tmp=$(${pkgs.coreutils}/bin/mktemp)
        ${pkgs.jq}/bin/jq '.hooks.wallpaperChange = "${wallpaperHook}"' "$guiSettings" > "$tmp"
        ${pkgs.coreutils}/bin/mv "$tmp" "$guiSettings"
      fi
    '';

    programs.noctalia-shell.settings = {
      colorSchemes = {
        darkMode = true;
        manualSunrise = "06:30";
        manualSunset = "18:30";
        matugenSchemeType = "scheme-content";
        schedulingMode = "off";
        useWallpaperColors = true;
      };
      hooks = {
        darkModeChange = "";
        enabled = true;
        performanceModeDisabled = "";
        performanceModeEnabled = "";
        screenLock = "";
        screenUnlock = "";
        wallpaperChange = "${wallpaperHook}";
      };
      templates = {
        alacritty = false;
        cava = false;
        code = false;
        discord = false;
        emacs = false;
        enableUserTemplates = false;
        foot = false;
        fuzzel = false;
        ghostty = true;
        gtk = false;
        helix = false;
        hyprland = false;
        kcolorscheme = false;
        kitty = true;
        mango = false;
        niri = false;
        pywalfox = false;
        qt = false;
        spicetify = false;
        telegram = false;
        vicinae = false;
        walker = false;
        wezterm = false;
        yazi = false;
        zed = false;
        zenBrowser = false;
      };
    };
  };
}
