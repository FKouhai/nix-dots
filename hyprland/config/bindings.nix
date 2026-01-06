{
  lib,
  vars,
  ...
}:
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
    "$mod, N, exec, swaync-client -t -sw"
    "$mod, V, togglefloating,"
    "$mod, P, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
    "$mod SHIFT, R, exec, wlogout"
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
  ++ lib.optionals (vars.shell == "caelestia") [
    "$mod, B, global, caelestia:lock"
    "$mod, F, global, caelestia:launcher"
    "$mod, R, exec, fuzzel"
    "$mod, S, exec, caelestia screenshot -r"
    "$mod+Shift, S, global, caelestia:screenshotFreeze"
    "$mod+Shift+Alt, S, global, caelestia:screenshot"
    "$mod, N, exec, caelestia shell drawers toggle sidebar"
    # Media controls
    ", XF86AudioPlay, global, caelestia:mediaToggle"
    ", XF86AudioPause, global, caelestia:mediaToggle"
    ", XF86AudioNext, global, caelestia:mediaNext"
    ", XF86AudioPrev, global, caelestia:mediaPrev"
    # Brightness
    ", XF86MonBrightnessUp, global, caelestia:brightnessUp"
    ", XF86MonBrightnessDown, global, caelestia:brightnessDown"
    # Session
    "$mod+Shift, L, exec, systemctl suspend-then-hibernate"
    # Recording
    "$mod+Alt, R, exec, caelestia record -s"
    "Ctrl+Alt, R, exec, caelestia record"
    "$mod+Shift+Alt, R, exec, caelestia record -r"
  ]
  ++ lib.optionals (vars.shell == "noctalia") [
    "$mod, B, exec,  noctalia-shell ipc call lockScreen lock"
    "$mod, F, exec, noctalia-shell ipc call launcher toggle"
    "$mod, S, exec, flameshot gui"
    "$mod, N, exec, noctalia-shell ipc call controlCenter toggle"
  ]
  ++ lib.optionals (vars.shell == "hyprpanel") [
    "$mod, B, exec, hyprpanel -t power"
    "$mod, F, exec, fuzzel"
    "$mod, R, exec, wofi --show drun"
    "$mod, S, exec, grimblast --freeze copy area"
    "$mod, N, exec, swaync-client -t -sw"
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
