{
  bar,
  lib,
}:
{
  exec-once = [
    "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "add_record_player"
  ]
  ++ lib.optionals (bar == "noctalia") [ "noctalia-shell" ]
  ++ [
    "wl-paste --watch cliphist store &"
  ];
}
