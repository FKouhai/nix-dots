{
  lib,
  pkgs,
  vars,
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
        portalPackage = pkgs.xdg-desktop-portal-hyprland;
        settings = {
          general = {
            gaps_in = 5;
            gaps_out = 10;
            border_size = 2;
            allow_tearing = true;
            layout = "dwindle";
          };
          input = {
            kb_layout = "us";
            kb_variant = "altgr-intl";
          };
          decoration = {
            rounding = 10;
            blur = {
              enabled = true;
              size = 7;
              passes = 3;
              new_optimizations = true;
              noise = 0.08;
              contrast = 1.5;
              xray = false;
              ignore_opacity = true;
            };
          };

          monitor = [
            "${vars.mainMonitor.name},${vars.mainMonitor.width}x${vars.mainMonitor.height}@${vars.mainMonitor.refresh},0x0,1"
            "${vars.secondaryMonitor.name},${vars.secondaryMonitor.width}x${vars.secondaryMonitor.height}@${vars.secondaryMonitor.refresh},2560x0,1"
          ];
          env = [
            "BROWSER=zen"
            "XDG_CONFIG_HOME=/home/franky/.config"
            "XDG_SESSION_TYPE=wayland"
            "XCURSOR_SIZE=22"
            "EDITOR=nvim"
            "QT_STYLE_OVERRIDE=''"
          ];
          exec-once = [
            "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
            "add_record_player"
            "caelestia wallpaper --file ${vars.wallpaper}"
            "wl-paste --watch cliphist store &"
          ];
        }
        // (import ./config/animations.nix)
        // (import ./config/windowrules.nix)
        // (import ./config/bindings.nix);
      };
    }
  );
}
