{
  bar,
  lib,
}:
{
  exec-once = [
    "dbus-update-activation-environment --systemd --all"
    "add_record_player"
  ]
  ++ [
    "wl-paste --watch cliphist store &"
  ];
}
