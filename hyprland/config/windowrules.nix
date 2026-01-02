{
  windowrule = [
    "float on, pin on, no_shadow on, size (monitor_w*0.25) (monitor_h*0.25), move ((monitor_w*1)-window_w-20), no_initial_focus on, match:title (Picture-in-Picture)"
    "float on, match:class ^(pavucontrol)$"
    "float on, match:title ^(Volume Control)$"
    "float on, pin on, no_shadow on, size (monitor_w*0.5) (monitor_h*0.5), move ((monitor_w*1)-window_w-20), no_initial_focus on, match:class (mpv)"
    "opacity 0.90 0.90, match:class ^(Cider)$"
    "opacity 0.90 0.90, match:class ^(cosmic-files)$"
    "opacity 0.90 0.90, match:class ^(vesktop)$"
    "opacity 1.0 1.0, no_blur on, match:class ^(zen-beta)$"
  ];
}
