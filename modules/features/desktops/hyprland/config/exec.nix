{
  bar,
  lib,
}:
{
  exec-once = [
    "dbus-update-activation-environment --systemd --all"
    "add_record_player"
  ]
  ++ lib.optionals (bar == "noctalia") [ "noctalia-shell" ]
  ++ [
    "wl-paste --watch cliphist store &"
  ];
}
