{
  animations = {
    enabled = true;
    bezier = [
      "myBezier, 0.10, 0.9, 0.1, 1.05"
      "wind, 0.05, 0.9, 0.1, 1.05"
      "windIn, 0.1, 1.1, 0.1, 1.1"
      "windOut, 0.3, -0.3, 0, 1"
      "liner, 1, 1, 1, 1"
    ];
    animation = [
      "windows, 1, 6, wind, slide"
      "windowsIn, 1, 6, windIn, slide"
      "windowsOut, 1, 5, windOut, slide"
      "windowsMove, 1, 5, wind, slide"
      "border, 1, 1, liner"
      "borderangle, 1, 30, liner, loop"
      "fade, 1, 10, default"
      "workspaces, 1, 5, wind"
      "hyprfocusIn, 1, 1.7, myBezier"
      "hyprfocusOut, 1, 1.7, myBezier"
    ];
  };
}