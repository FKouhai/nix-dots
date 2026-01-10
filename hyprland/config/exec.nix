{ vars, lib }:
{
  exec-once = [
    "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "add_record_player"
  ]
  ++ lib.optionals (vars.shell == "caelestia") [
    "caelestia wallpaper --file ${vars.wallpaper}"
    "caelestia scheme set -n dynamic --variant fidelity"
  ]
  ++ [
    "wl-paste --watch cliphist store &"
  ];
}
