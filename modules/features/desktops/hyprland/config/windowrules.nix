{
  window_rule = [
    {
      float = true;
      pin = true;
      no_shadow = true;
      size = "(monitor_w*0.25) (monitor_h*0.25)";
      move = "(monitor_w - window_w - 20) 20";
      no_initial_focus = true;
      match.title = "Picture-in-Picture";
    }
    { float = true; match.class = "^(pavucontrol)$"; }
    { float = true; match.title = "^(Volume Control)$"; }
    {
      float = true;
      pin = true;
      no_shadow = true;
      size = "(monitor_w*0.5) (monitor_h*0.5)";
      move = "(monitor_w - window_w - 20) 20";
      no_initial_focus = true;
      match.class = "mpv";
    }
    { opacity = 0.90; match.class = "^(Cider)$"; }
    { opacity = 0.90; match.class = "^(cosmic-files)$"; }
    { opacity = 0.90; match.class = "^(vesktop)$"; }
    { opacity = 1.0; no_blur = true; match.class = "^(zen-beta)$"; }
  ];
}
