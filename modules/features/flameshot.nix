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

  systemd.user.services.flameshot = {
    Service.Environment = [
      "PATH=${pkgs.grim}/bin:${lib.makeBinPath [ pkgs.flameshot ]}"
      "QT_QPA_PLATFORM=wayland"
      "XDG_SESSION_TYPE=wayland"
    ];
  };

  wayland.windowManager.hyprland.settings = {
    window_rule = [
      {
        no_anim = true;
        float = true;
        move = "(0) (0)";
        pin = true;
        no_initial_focus = true;
        match.title = "^(flameshot)$";
      }
      {
        monitor = 1;
        match.class = "^(flameshot)$";
      }
    ];
  };
}
