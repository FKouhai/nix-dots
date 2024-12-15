{pkgs, ...}:
{
  services.hyprpaper = {
    enable=true;
    package = pkgs.hyprpaper;
    settings = {
      ipc = "on";
      splash = false;
      preload = ["/home/franky/wallpapers/wall-01.png"];
      wallpaper = [
        "eDP-1,/home/franky/wallpapers/wall-01.png"
        "HDMI-A-1,/home/franky/wallpapers/wall-01.png"
      ];

    };
  };
  programs.kitty = {
    enable=true;
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
      theme = "Glacier";
    };
  wayland.windowManager.hyprland.enable=true;
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
        enabled = false ;
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
      "eDP-1,1920x1080@60,0x0,1"
      "HDMI-A-1,1920x1080@60,1920x0,1"
      ];
    env = [
    "BROWSER=zen"
    "XDG_CONFIG_HOME=/home/franky/.config"
    "XCURSOR_SIZE=22"
    "EDITOR=nvim"
    ];
    "$mod" = "SUPER";
    exec-once = [ 
    "hyprpanel &"
    "hyprpaper &"
    "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    ];
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    bind=[
    "$mod, RETURN, exec,kitty"
    "$mod, W, exec, zen"
    "$mod, C, exec, cider"
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
    ++ (
      builtins.concatLists (builtins.genList (i:
        let ws = i+1;
	in [
	"$mod, code:1${toString i},workspace, ${toString ws}"
	"$mod SHIFT, code:1${toString i},movetoworkspace, ${toString ws}"

	]

      )9)

    );

  };

}
