{
  config.animations.enabled = true;

  curve = [
    {
      _args = [
        "md3_decel"
        {
          type = "bezier";
          points = [
            [
              0.05
              0.7
            ]
            [
              0.1
              1
            ]
          ];
        }
      ];
    }
    {
      _args = [
        "md3_accel"
        {
          type = "bezier";
          points = [
            [
              0.3
              0
            ]
            [
              0.8
              0.15
            ]
          ];
        }
      ];
    }
    {
      _args = [
        "menu_decel"
        {
          type = "bezier";
          points = [
            [
              0.1
              1
            ]
            [
              0
              1
            ]
          ];
        }
      ];
    }
    {
      _args = [
        "menu_accel"
        {
          type = "bezier";
          points = [
            [
              0.38
              0.04
            ]
            [
              1
              0.07
            ]
          ];
        }
      ];
    }

    {
      _args = [
        "spring_menu"
        {
          type = "spring";
          mass = 1;
          stiffness = 80;
          dampening = 14;
        }
      ];
    }
    {
      _args = [
        "spring_window"
        {
          type = "spring";
          mass = 1;
          stiffness = 30;
          dampening = 8;
        }
      ];
    }
    {
      _args = [
        "spring_open"
        {
          type = "spring";
          mass = 1;
          stiffness = 30;
          dampening = 8;
        }
      ];
    }
    {
      _args = [
        "spring_workspace"
        {
          type = "spring";
          mass = 1.2;
          stiffness = 30;
          dampening = 10;
        }
      ];
    }
    {
      _args = [
        "spring_special"
        {
          type = "spring";
          mass = 1;
          stiffness = 30;
          dampening = 8;
        }
      ];
    }
  ];

  animation = [
    {
      leaf = "windows";
      enabled = true;
      speed = 1;
      spring = "spring_window";
    }
    {
      leaf = "windowsIn";
      enabled = true;
      speed = 1;
      spring = "spring_open";
      style = "popin 40%";
    }
    {
      leaf = "windowsOut";
      enabled = true;
      speed = 3;
      bezier = "md3_accel";
      style = "popin 60%";
    }
    {
      leaf = "border";
      enabled = false;
    }
    {
      leaf = "borderangle";
      enabled = false;
    }
    {
      leaf = "fade";
      enabled = true;
      speed = 3;
      bezier = "md3_decel";
    }
    {
      leaf = "zoomFactor";
      enabled = true;
      speed = 6;
      bezier = "md3_decel";
    }
    {
      leaf = "layersIn";
      enabled = true;
      speed = 3;
      spring = "spring_menu";
      style = "slide";
    }
    {
      leaf = "layersOut";
      enabled = true;
      speed = 1.6;
      bezier = "menu_accel";
      style = "slide";
    }
    {
      leaf = "fadeLayersIn";
      enabled = true;
      speed = 2;
      bezier = "menu_decel";
    }
    {
      leaf = "fadeLayersOut";
      enabled = true;
      speed = 1.6;
      bezier = "menu_accel";
    }
    {
      leaf = "workspaces";
      enabled = true;
      speed = 1;
      spring = "spring_workspace";
      style = "slide";
    }
    {
      leaf = "specialWorkspace";
      enabled = true;
      speed = 1;
      spring = "spring_special";
      style = "slidefadevert 40%";
    }
  ];
}
