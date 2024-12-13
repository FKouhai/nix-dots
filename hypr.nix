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
        shell_integration = "enabled";
        shell = "zsh";
      };
      theme = "Glacier";
    };
  wayland.windowManager.hyprland.enable=true;
  wayland.windowManager.hyprland.settings = {
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
