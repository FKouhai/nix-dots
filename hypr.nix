{
  pkgs,
  vars,
  config,
  inputs,
  ...
}:
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
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ vars.wallpaper ];
      wallpaper = [
        "${vars.mainMonitor.name},${vars.wallpaper}"
        "${vars.secondaryMonitor.name},${vars.wallpaper}"
      ];
    };
  };
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Hack Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      enable_audio_bell = false;
      scrollback_lines = -1;
      tab_bar_edge = "top";
      allow_remote_control = "yes";
    };
    shellIntegration = {
      enableZshIntegration = true;
    };
    themeFile = "kanagawa";
  };
  wayland.windowManager.hyprland = {
    enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    plugins = [
      pkgs.hyprlandPlugins.hyprtrails
      pkgs.hyprlandPlugins.hyprfocus
    ];
    settings = {
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        allow_tearing = true;
        layout = "dwindle";
      };
      plugin = {
        hyprtrails = {
          color = "rgba(ffaa00ff)";
        };
        hyprfocus = {
          mode = "flash";
        };
      };
      decoration = {
        rounding = 10;
        blur = {
          enabled = false;
          size = 7;
          passes = 4;
          new_optimizations = true;
        };
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.10, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier, slide"
          "windowsOut, 1, 7, myBezier, slide"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      windowrule = [
        "float,title:(Picture-in-Picture)"
        "pin,title:(Picture-in-Picture)"
        "noshadow,title:(Picture-in-Picture)"
        "size 25% 25%,title:(Picture-in-Picture)"
        "move 100%-w-20,title:(Picture-in-Picture)"
        "noinitialfocus,title:(Picture-in-Picture)"
        "float,class:(mpv)"
        "pin,class:(mpv)"
        "noshadow,class:(mpv)"
        "size 50% 50%,class:(mpv)"
        "move 100%-w-20,class:(mpv)"
        "noinitialfocus,class:(mpv)"
        "float, class:(GLava)"
        "size 100% 25%,class:(GLava)"
        "move 100%-w-20,class:(GLava)"
        "noshadow,class:(GLava)"
        "noinitialfocus,title:(GLava)"
      ];
      monitor = [
        "${vars.mainMonitor.name},${vars.mainMonitor.width}x${vars.mainMonitor.height}@${vars.mainMonitor.refresh},0x0,1"
        "${vars.secondaryMonitor.name},${vars.secondaryMonitor.width}x${vars.secondaryMonitor.height}@${vars.secondaryMonitor.refresh},2560x0,1"
      ];
      env = [
        "BROWSER=brave"
        "XDG_CONFIG_HOME=/home/franky/.config"
        "XDG_SESSION_TYPE=wayland"
        "XCURSOR_SIZE=22"
        "EDITOR=nvim"
        "QT_STYLE_OVERRIDE=''"
      ];
      "$mod" = "SUPER";
      exec-once = [
        "hyprpanel &"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "hyprpaper &"
        "add_record_player"
        "wl-paste --watch cliphist store &"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bind = [
        "$mod, RETURN, exec,ghostty"
        "$mod, W, exec, brave"
        "$mod, C, exec, Cider"
        "$mod, D, exec,vesktop"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, cosmic-files"
        "$mod, B, exec, hyprlock"
        "$mod, N, exec, swaync-client -t -sw"
        "$mod, V, togglefloating,"
        "$mod, R, exec, fuzzel"
        "$mod, P, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
        "$mod, S, exec, hyprshot -m region"
        "$mod SHIFT, R, exec, wlogout"
        "$mod, D, exec, vesktop --enable-features=UseOzonePlatform --ozone-platform=wayland --ozone-platform-hint=auto "
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i},workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i},movetoworkspace, ${toString ws}"
          ]
        ) 9
      ));
    };
  };
}
