{
  pkgs,
  config,
  lib,
  ...
}:
{
  services.flameshot = {
    enable = true;

    # Enable wayland support with this build flag
    package = pkgs.flameshot.override {
      enableWlrSupport = true;
    };

    settings = {
      General = {
        disabledTrayIcon = false;
        showStartupLaunchMessage = false;

        # Auto save to this path
        savePath = "${config.home.homeDirectory}/Pictures/";
        savePathFixed = true;
        saveAsFileExtension = ".jpg";
        filenamePattern = "%F_%H-%M";
        drawThickness = 1;
        copyPathAfterSave = true;

        # For wayland
        useGrimAdapter = true;
        disabledGrimWarning = true;
      };
    };
  };

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "no_anim on, float on, move (0) (0), pin on, no_initial_focus on, match:title ^(flameshot)$"
      "monitor 1, match:class ^(flameshot)$"
    ];
  };
}
