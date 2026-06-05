{
  lib,
  pkgs,
  config,
  ...
}:
let
  generator = pkgs.writeShellApplication {
    name = "generate-bat-theme";
    runtimeInputs = [ pkgs.jq ];
    text = ''
            colors="$HOME/.config/noctalia/colors.json"
            theme_dir="$HOME/.config/bat/themes"
            out="$theme_dir/noctalia.tmTheme"

            [ -f "$colors" ] || exit 0

            surface=$(jq -r '.mSurface' "$colors")
            surface_variant=$(jq -r '.mSurfaceVariant' "$colors")
            on_surface=$(jq -r '.mOnSurface' "$colors")
            on_surface_variant=$(jq -r '.mOnSurfaceVariant' "$colors")
            outline=$(jq -r '.mOutline' "$colors")
            primary=$(jq -r '.mPrimary' "$colors")
            secondary=$(jq -r '.mSecondary' "$colors")
            error=$(jq -r '.mError' "$colors")
            hover=$(jq -r '.mHover' "$colors")
            green=$(jq -r '.mGreen' "$colors")
            orange=$(jq -r '.mOrange' "$colors")
            yellow=$(jq -r '.mYellow' "$colors")

            mkdir -p "$theme_dir"

            cat > "$out" << EOF
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>name</key>
        <string>Noctalia</string>
        <key>settings</key>
        <array>
          <dict>
            <key>settings</key>
            <dict>
              <key>background</key><string>$surface</string>
              <key>foreground</key><string>$on_surface</string>
              <key>caret</key><string>$primary</string>
              <key>selection</key><string>$surface_variant</string>
              <key>selectionForeground</key><string>$on_surface</string>
              <key>lineHighlight</key><string>$surface_variant</string>
              <key>invisibles</key><string>$outline</string>
            </dict>
          </dict>
          <dict>
            <key>name</key><string>Comment</string>
            <key>scope</key><string>comment, punctuation.definition.comment</string>
            <key>settings</key>
            <dict>
              <key>foreground</key><string>$on_surface_variant</string>
              <key>fontStyle</key><string>italic</string>
            </dict>
          </dict>
          <dict>
            <key>name</key><string>String</string>
            <key>scope</key><string>string, string.quoted, string.template</string>
            <key>settings</key>
            <dict><key>foreground</key><string>$green</string></dict>
          </dict>
          <dict>
            <key>name</key><string>Keyword</string>
            <key>scope</key><string>keyword, keyword.control, storage, storage.type, storage.modifier</string>
            <key>settings</key>
            <dict><key>foreground</key><string>$secondary</string></dict>
          </dict>
          <dict>
            <key>name</key><string>Function</string>
            <key>scope</key><string>entity.name.function, entity.name.method, support.function</string>
            <key>settings</key>
            <dict><key>foreground</key><string>$primary</string></dict>
          </dict>
          <dict>
            <key>name</key><string>Type</string>
            <key>scope</key><string>entity.name.type, entity.name.class, support.type, support.class</string>
            <key>settings</key>
            <dict><key>foreground</key><string>$hover</string></dict>
          </dict>
          <dict>
            <key>name</key><string>Section</string>
            <key>scope</key><string>entity.name.section, entity.name.tag</string>
            <key>settings</key>
            <dict><key>foreground</key><string>$primary</string></dict>
          </dict>
          <dict>
            <key>name</key><string>Property</string>
            <key>scope</key><string>support.type.property-name, variable.other.key, meta.mapping.key</string>
            <key>settings</key>
            <dict><key>foreground</key><string>$primary</string></dict>
          </dict>
          <dict>
            <key>name</key><string>Constant</string>
            <key>scope</key><string>constant.numeric, constant.language, constant.character</string>
            <key>settings</key>
            <dict><key>foreground</key><string>$orange</string></dict>
          </dict>
          <dict>
            <key>name</key><string>Variable</string>
            <key>scope</key><string>variable, variable.language, variable.other</string>
            <key>settings</key>
            <dict><key>foreground</key><string>$on_surface</string></dict>
          </dict>
          <dict>
            <key>name</key><string>Operator</string>
            <key>scope</key><string>keyword.operator</string>
            <key>settings</key>
            <dict><key>foreground</key><string>$hover</string></dict>
          </dict>
          <dict>
            <key>name</key><string>Punctuation</string>
            <key>scope</key><string>punctuation, meta.brace, meta.delimiter</string>
            <key>settings</key>
            <dict><key>foreground</key><string>$outline</string></dict>
          </dict>
          <dict>
            <key>name</key><string>Attribute</string>
            <key>scope</key><string>entity.other.attribute-name</string>
            <key>settings</key>
            <dict><key>foreground</key><string>$yellow</string></dict>
          </dict>
          <dict>
            <key>name</key><string>Invalid</string>
            <key>scope</key><string>invalid, invalid.illegal</string>
            <key>settings</key>
            <dict>
              <key>foreground</key><string>$error</string>
              <key>fontStyle</key><string>underline</string>
            </dict>
          </dict>
        </array>
      </dict>
      </plist>
      EOF

    '';
  };
in
{
  options.bars.noctalia.themes.bat.enable = lib.mkEnableOption "bat noctalia theme" // {
    default = true;
  };

  config = lib.mkIf (config.bars.noctalia.enable && config.bars.noctalia.themes.bat.enable) {
    bars.noctalia.themeGenerators = [ generator ];

    home.activation.seedBatTheme = lib.hm.dag.entryAfter [ "unlockNoctaliaColors" ] ''
      ${generator}/bin/generate-bat-theme || true
      ${pkgs.bat}/bin/bat cache --build 2>/dev/null || true
    '';

    stylix.targets.bat.enable = lib.mkForce false;
    programs.bat.config.theme = "noctalia";
  };
}
