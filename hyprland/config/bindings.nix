{
  "$mod" = "SUPER";
  bindm = [
    "$mod, mouse:272, movewindow"
    "$mod, mouse:273, resizewindow"
  ];
  bind = [
    "$mod, RETURN, exec,ghostty"
    "$mod, W, exec, zen"
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
    "$mod SHIFT, M, exec, hyprlock"
    "$mod, D, exec, vesktop --enable-features=UseOzonePlatform --ozone-platform=wayland --ozone-platform-hint=auto "
    "$mod, H, movefocus, l"
    "$mod, L, movefocus, r"
    "$mod, K, movefocus, u"
    "$mod, J, movefocus, d"
    "$mod+Shift, H, movewindow, l"
    "$mod+Shift, L, movewindow, r"
    "$mod+Shift, K, movewindow, u"
    "$mod+Shift, J, movewindow, d"
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
}
