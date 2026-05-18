{
  lib,
  pkgs,
  osConfig,
  config,
  inputs,
  ...
}:
{
  options = {
    hypr.enable = lib.mkEnableOption "Enable hypr module";
  };
  config = lib.mkIf config.hypr.enable (
    let
      add_record_player = pkgs.writeShellApplication {
        name = "add_record_player";
        text = ''
          # Wait a moment for audio services to fully start
          sleep 2
          # Set PCM2900C input volume to 100%
          pactl set-source-volume alsa_input.usb-BurrBrown_from_Texas_Instruments_USB_AUDIO_CODEC-00.pro-input-0 65536
          # Unmute PCM2900C input
          pactl set-source-mute alsa_input.usb-BurrBrown_from_Texas_Instruments_USB_AUDIO_CODEC-00.pro-input-0 false
          # Set Scarlett Solo output volume to 100%
          pactl set-sink-volume alsa_output.usb-Focusrite_Scarlett_Solo_USB_Y7RBNDQ2A68E32-00.pro-output-0 65536
          # Unmute Scarlett Solo output
          pactl set-sink-mute alsa_output.usb-Focusrite_Scarlett_Solo_USB_Y7RBNDQ2A68E32-00.pro-output-0 false
          # Create loopback from PCM2900C input to Scarlett Solo output
          pactl load-module module-loopback source=alsa_input.usb-BurrBrown_from_Texas_Instruments_USB_AUDIO_CODEC-00.pro-input-0 sink=alsa_output.usb-Focusrite_Scarlett_Solo_USB_Y7RBNDQ2A68E32-00.pro-output-0
          echo "PCM2900C to Scarlett Solo loopback configured successfully"
        '';
      };
    in
    {
      home.packages = [
        add_record_player
      ];
      dbus.packages = [
        pkgs.pass-secret-service
        pkgs.gcr
        pkgs.gnome-settings-daemon
        pkgs.libsecret
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        configType = "lua";
        portalPackage = pkgs.xdg-desktop-portal-hyprland;

        extraConfig =
          let
            execOnce =
              [ "add_record_player" ]
              ++ lib.optionals (osConfig.host.bar == "caelestia") [
                "caelestia wallpaper --file ${osConfig.host.wallpaper}"
                "caelestia scheme set -n dynamic --variant fidelity"
              ]
              ++ [ "wl-paste --watch cliphist store &" ];
          in
          ''
            hl.on("hyprland.start", function()
            ${lib.concatMapStrings (cmd: "  hl.exec_cmd(\"${cmd}\")\n") execOnce}end)
          '';

        settings =
          let
            c = config.lib.stylix.colors;
            rgb = color: "rgb(${color})";
            rgba = color: alpha: "rgba(${color}${alpha})";
          in
          lib.foldl' lib.recursiveUpdate
            {
              config = {
                input = {
                  kb_layout = "us";
                  kb_variant = "altgr-intl";
                  touchpad = {
                    clickfinger_behavior = true;
                    natural_scroll = true;
                  };
                };
                general = {
                  "col.active_border" = rgb c.base0D;
                  "col.inactive_border" = rgb c.base03;
                };
                decoration.shadow.color = rgba c.base00 "99";
                misc.background_color = rgb c.base00;
                group = {
                  "col.border_active" = rgb c.base0D;
                  "col.border_inactive" = rgb c.base03;
                  "col.border_locked_active" = rgb c.base0C;
                  groupbar = {
                    "col.active" = rgb c.base0D;
                    "col.inactive" = rgb c.base03;
                    text_color = rgb c.base05;
                  };
                };
              };

              monitor = [
                {
                  output = osConfig.host.mainMonitor.name;
                  mode = "${toString osConfig.host.mainMonitor.width}x${toString osConfig.host.mainMonitor.height}@${toString osConfig.host.mainMonitor.refresh}";
                  position = "0x0";
                  scale = 1;
                }
                {
                  output = osConfig.host.secondaryMonitor.name;
                  mode = "${toString osConfig.host.secondaryMonitor.width}x${toString osConfig.host.secondaryMonitor.height}@${toString osConfig.host.secondaryMonitor.refresh}";
                  position = "2560x0";
                  scale = 1;
                }
              ];

              env = [
                { _args = [ "BROWSER" "helium" ]; }
                { _args = [ "XDG_CONFIG_HOME" "/home/franky/.config" ]; }
                { _args = [ "XDG_SESSION_TYPE" "wayland" ]; }
                { _args = [ "XCURSOR_SIZE" "22" ]; }
                { _args = [ "EDITOR" "nvim" ]; }
                { _args = [ "QT_STYLE_OVERRIDE" "" ]; }
              ];
            }
            [
              (import ./config/general.nix)
              (import ./config/gestures.nix { inherit lib; })
              (import ./config/decoration.nix)
              (import ./config/animations.nix)
              (import ./config/windowrules.nix)
              (import ./config/bindings.nix {
                inherit lib;
                inherit (osConfig.host) bar;
              })
            ];
      };
    }
  );
}
