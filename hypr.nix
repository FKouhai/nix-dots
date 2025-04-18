{
  pkgs,
  vars,
  config,
  inputs,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      ipc = "on";
      splash = false;
      preload = [vars.wallpaper];
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
      background_opacity = "0.8";
      scrollback_lines = -1;
      tab_bar_edge = "top";
      allow_remote_control = "yes";
    };
    shellIntegration = {
      enableZshIntegration = true;
    };
    themeFile = "kanagawa";
  };
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
      allow_tearing = true;
      layout = "dwindle";
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
    monitor = [
      "${vars.mainMonitor.name},${vars.mainMonitor.width}x${vars.mainMonitor.height}@${vars.mainMonitor.refresh},0x0,1"
      "${vars.secondaryMonitor.name},${vars.secondaryMonitor.width}x${vars.secondaryMonitor.height}@${vars.secondaryMonitor.refresh},1920x0,1"
    ];
    env = [
      "BROWSER=zen"
      "XDG_CONFIG_HOME=/home/franky/.config"
      "XDG_SESSION_TYPE=wayland"
      "XCURSOR_SIZE=22"
      "EDITOR=nvim"
    ];
    "$mod" = "SUPER";
    exec-once = [
      "hyprpanel &"
      "hyprpaper &"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "pactl load-module module-loopback latency_msec=1"
    ];
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    bind =
      [
        "$mod, RETURN, exec,ghostty"
        "$mod, W, exec, zen"
        "$mod, C, exec, Cider"
        "$mod, D, exec,vesktop"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, thunar"
        "$mod, B, exec, hyprlock"
        "$mod, N, exec, swaync-client -t -sw"
        "$mod, V, togglefloating,"
        "$mod, R, exec, wofi --show drun"
        "$mod, S, exec, hyprshot -m region"
        "$mod SHIFT, R, exec, wlogout"
        "$mod, D, exec, vesktop --enable-features=UseOzonePlatform --ozone-platform=wayland --ozone-platform-hint=auto "
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i: let
            ws = i + 1;
          in [
            "$mod, code:1${toString i},workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i},movetoworkspace, ${toString ws}"
          ]
        )
        9
      ));
  };
}
