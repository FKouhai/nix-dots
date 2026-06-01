{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:
let
  mkColors = t: {
    mError = "#${t.base08}";
    mGreen = "#${t.base0B}";
    mHover = "#${t.base0C}";
    mOnError = "#${t.base00}";
    mOnHover = "#${t.base00}";
    mOnPrimary = "#${t.base00}";
    mOnSecondary = "#${t.base00}";
    mOnSurface = "#${t.base05}";
    mOnSurfaceVariant = "#${t.base04}";
    mOnTertiary = "#${t.base00}";
    mOrange = "#${t.base09}";
    mOutline = "#${t.base03}";
    mPink = "#${t.base0F}";
    mPrimary = "#${t.base0D}";
    mSecondary = "#${t.base0E}";
    mShadow = "#${t.base00}";
    mSurface = "#${t.base00}";
    mSurfaceVariant = "#${t.base01}";
    mTertiary = "#${t.base0C}";
    mYellow = "#${t.base0A}";
    tBg     = "#${t.base00}";
    tFg     = "#${t.base05}";
    tCursor = "#${t.base0D}";
    tSelBg  = "#${t.base02}";
    tSelFg  = "#${t.base04}";
    t0      = "#${t.base00}";
    t1      = "#${t.base08}";
    t2      = "#${t.base0B}";
    t3      = "#${t.base0A}";
    t4      = "#${t.base0D}";
    t5      = "#${t.base0E}";
    t6      = "#${t.base0C}";
    t7      = "#${t.base05}";
    t8      = "#${t.base03}";
    t9      = "#${t.base08}";
    t10     = "#${t.base0B}";
    t11     = "#${t.base0A}";
    t12     = "#${t.base0D}";
    t13     = "#${t.base0E}";
    t14     = "#${t.base0C}";
    t15     = "#${t.base07}";
  };

  defaultNoctaliaColors = pkgs.writeText "noctalia-colors-default.json"
    (builtins.toJSON (mkColors osConfig.host.themeData.base16Scheme));

  kanoxoDragonColors =
    let dragonBase = {
      base00 = "181616"; base01 = "1e1c1c"; base02 = "272525"; base03 = "555055";
      base04 = "b8b4ac"; base05 = "cac8c0"; base06 = "d0ccb8"; base07 = "dcd7ba";
      base08 = "cc6080"; base09 = "c8886a"; base0A = "c4b08a"; base0B = "70b870";
      base0C = "48b8b0"; base0D = "90b0cc"; base0E = "b098e0"; base0F = "c88098";
    };
    in pkgs.writeText "noctalia-colors-kanoxo-dragon.json" (builtins.toJSON (
      (mkColors dragonBase) // {
        t0  = "#0d0c0c";
        t9  = "#e07090";
        t10 = "#88cc88";
        t11 = "#d4c4a0";
        t12 = "#7fb4ca";
        t13 = "#c8a8f0";
        t14 = "#60c8c0";
      }
    ));

  kanoxoWaveColors =
    let waveBase = {
      base00 = "1c1c24"; base01 = "16161f"; base02 = "252334"; base03 = "5f5c78";
      base04 = "c8c4a0"; base05 = "dcd7ba"; base06 = "e9e5d0"; base07 = "f0ece0";
      base08 = "d04870"; base09 = "e89060"; base0A = "c8aa72"; base0B = "5cc070";
      base0C = "38ccc4"; base0D = "80aaff"; base0E = "b08cf0"; base0F = "d880a8";
    };
    in pkgs.writeText "noctalia-colors-kanoxo-wave.json" (builtins.toJSON (
      (mkColors waveBase) // {
        t0  = "#16161f";
        t9  = "#e05888";
        t10 = "#72d888";
        t11 = "#dcc07e";
        t12 = "#7fb4ca";
        t13 = "#c49cf8";
        t14 = "#50d8d0";
      }
    ));

  # jq filter that fills in derived fields noctalia doesn't write (using // null-coalescing)
  augmentFilter = pkgs.writeText "noctalia-augment-colors.jq" ''
    . + {
      mGreen:  (.mGreen  // .mTertiary),
      mOrange: (.mOrange // .mError),
      mYellow: (.mYellow // .mHover),
      mPink:   (.mPink   // .mSecondary),
      tBg:    (.tBg    // .mSurface),
      tFg:    (.tFg    // .mOnSurface),
      tCursor:(.tCursor // .mPrimary),
      tSelBg: (.tSelBg  // .mSurfaceVariant),
      tSelFg: (.tSelFg  // .mOnSurfaceVariant),
      t0:  (.t0  // .mSurface),
      t1:  (.t1  // .mError),
      t2:  (.t2  // .mTertiary),
      t3:  (.t3  // .mHover),
      t4:  (.t4  // .mPrimary),
      t5:  (.t5  // .mSecondary),
      t6:  (.t6  // .mTertiary),
      t7:  (.t7  // .mOnSurface),
      t8:  (.t8  // .mOutline),
      t9:  (.t9  // .mError),
      t10: (.t10 // .mTertiary),
      t11: (.t11 // .mHover),
      t12: (.t12 // .mPrimary),
      t13: (.t13 // .mSecondary),
      t14: (.t14 // .mTertiary),
      t15: (.t15 // .mOnSurface)
    }
  '';

  wallpaperHook = pkgs.writeShellScript "noctalia-wallpaper-hook" ''
    wallpaper="''${1:-}"
    colors="$HOME/.config/noctalia/colors.json"

    case "$wallpaper" in
      *kanoxo-dragon*)
        ${pkgs.coreutils}/bin/cp -f ${kanoxoDragonColors} "$colors"
        ${pkgs.coreutils}/bin/chmod 644 "$colors"
        ;;
      *kanoxo-wave*)
        ${pkgs.coreutils}/bin/cp -f ${kanoxoWaveColors} "$colors"
        ${pkgs.coreutils}/bin/chmod 644 "$colors"
        ;;
    esac

    tmp=$(${pkgs.coreutils}/bin/mktemp)
    ${pkgs.jq}/bin/jq -f ${augmentFilter} "$colors" > "$tmp" && ${pkgs.coreutils}/bin/mv "$tmp" "$colors"

    ${lib.concatMapStrings (gen: "${gen}/bin/${gen.name} || true &\n") config.bars.noctalia.themeGenerators}
    wait
    ${pkgs.bat}/bin/bat cache --build 2>/dev/null || true
  '';

  hookCmd = "${wallpaperHook} \"$1\"";

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
    home.packages = config.bars.noctalia.themeGenerators;

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
      tmp=$(${pkgs.coreutils}/bin/mktemp)
      ${pkgs.jq}/bin/jq -f ${augmentFilter} "$colors" > "$tmp" && ${pkgs.coreutils}/bin/mv "$tmp" "$colors"
    '';

    home.activation.patchNoctaliaGuiSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      guiSettings="$HOME/.config/noctalia/gui-settings.json"
      if [ -f "$guiSettings" ]; then
        tmp=$(${pkgs.coreutils}/bin/mktemp)
        ${pkgs.jq}/bin/jq --arg hook '${hookCmd}' '.hooks.wallpaperChange = $hook' "$guiSettings" > "$tmp"
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
        wallpaperChange = hookCmd;
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
