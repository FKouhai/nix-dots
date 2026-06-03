{ lib, bar, ... }:
let
  mk = keys: dsp: {
    _args = [
      keys
      (lib.generators.mkLuaInline dsp)
    ];
  };
  mkO = keys: dsp: opts: {
    _args = [
      keys
      (lib.generators.mkLuaInline dsp)
      opts
    ];
  };
  exec = cmd: "hl.dsp.exec_cmd(\"${cmd}\")";
  focus = dir: "hl.dsp.focus({ direction = \"${dir}\" })";
  wMove = dir: "hl.dsp.window.move({ direction = \"${dir}\" })";
  wsSwitch = ws: "hl.dsp.focus({ workspace = ${ws} })";
  wsMoveTo = ws: "hl.dsp.window.move({ workspace = ${ws} })";
  global = name: "hl.dsp.global(\"${name}\")";
in
{
  bind = [
    (mk "SUPER + RETURN" (exec "ghostty"))
    (mk "SUPER + W" (exec "helium"))
    (mk "SUPER + C" (exec "Cider"))
    (mk "SUPER + Q" "hl.dsp.window.close()")
    (mk "SUPER + M" "hl.dsp.exit()")
    (mk "SUPER + E" (exec "cosmic-files"))
    (mk "SUPER + V" "hl.dsp.window.float()")
    (mk "SUPER + P" (exec "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"))
    (mk "SUPER + D" (exec "vesktop"))
    (mk "SUPER + H" (focus "l"))
    (mk "SUPER + L" (focus "r"))
    (mk "SUPER + K" (focus "u"))
    (mk "SUPER + J" (focus "d"))
    (mk "SUPER + SHIFT + H" (wMove "l"))
    (mk "SUPER + SHIFT + L" (wMove "r"))
    (mk "SUPER + SHIFT + K" (wMove "u"))
    (mk "SUPER + SHIFT + J" (wMove "d"))
    (mk "SUPER + mouse_down" (wsSwitch "\"e+1\""))
    (mk "SUPER + mouse_up" (wsSwitch "\"e-1\""))
    (mk "XF86AudioRaiseVolume" (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
    (mk "XF86AudioLowerVolume" (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
    (mkO "SUPER + mouse:272" "hl.dsp.window.drag()" { mouse = true; })
    (mkO "SUPER + mouse:273" "hl.dsp.window.resize()" { mouse = true; })
  ]
  ++ lib.optionals (bar == "noctalia") [
    (mk "SUPER + B" (exec "noctalia msg session lock"))
    (mk "SUPER + SHIFT + A" (exec "noctalia msg control-center audio"))
    (mk "SUPER + SHIFT + B" (exec "noctalia msg control-center bluetooth"))
    (mk "SUPER + F" (exec "noctalia msg panel-toggle launcher"))
    (mk "SUPER + S" (exec "hyprshot -m region --clipboard-only"))
    (mk "SUPER + SHIFT + R" (exec "noctalia msg panel-toggle session"))
    (mk "SUPER + X" (exec "noctalia msg settings-toggle"))
    (mk "SUPER + SHIFT + S" (exec "obs"))
    (mk "SUPER + SHIFT + N" (exec "noctalia msg nightlight-toggle"))
    (mk "SUPER + N" (exec "noctalia msg control-center notifications"))
    (mk "SUPER + SHIFT + W" (exec "noctalia msg panel-toggle wallpaper"))
    (mk "SUPER + SHIFT + C" (exec "noctalia msg panel-toggle control-center"))
  ]
  ++ (builtins.concatLists (
    builtins.genList (
      i:
      let
        ws = i + 1;
      in
      [
        (mk "SUPER + code:1${toString i}" (wsSwitch (toString ws)))
        (mk "SUPER + SHIFT + code:1${toString i}" (wsMoveTo (toString ws)))
      ]
    ) 9
  ));
}
