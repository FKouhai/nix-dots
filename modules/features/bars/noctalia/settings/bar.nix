{
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.bars.noctalia.enable {
    programs.noctalia-shell.settings.bar = {
      backgroundOpacity = lib.mkForce 0;
      capsuleOpacity = lib.mkForce 1;
      density = lib.mkForce "comfortable";
      exclusive = lib.mkForce true;
      floating = lib.mkForce true;
      marginHorizontal = lib.mkForce 1;
      marginVertical = lib.mkForce 0.25;
      monitors = [ ];
      outerCorners = true;
      position = "top";
      showCapsule = true;
      showOutline = true;
      useSeparateOpacity = true;
      widgets = {
        center = [
          {
            characterCount = 2;
            colorizeIcons = false;
            enableScrollWheel = true;
            followFocusedScreen = false;
            groupedBorderOpacity = 1;
            hideUnoccupied = false;
            iconScale = 0.8;
            id = "Workspace";
            labelMode = "index";
            showApplications = false;
            showLabelsOnlyWhenOccupied = true;
            unfocusedIconsOpacity = 1;
          }
        ];
        left = [
          {
            icon = "rocket";
            id = "Launcher";
            usePrimaryColor = false;
          }
          {
            customFont = "";
            formatHorizontal = "HH:mm ddd, MMM dd";
            formatVertical = "HH mm - dd MM";
            id = "Clock";
            tooltipFormat = "HH:mm ddd, MMM dd";
            useCustomFont = false;
            usePrimaryColor = false;
          }
          {
            compactMode = true;
            diskPath = "/";
            id = "SystemMonitor";
            showCpuTemp = true;
            showCpuUsage = true;
            showDiskUsage = false;
            showGpuTemp = false;
            showLoadAverage = false;
            showMemoryAsPercent = false;
            showMemoryUsage = true;
            showNetworkStats = false;
            useMonospaceFont = true;
            usePrimaryColor = false;
          }
          {
            colorizeIcons = false;
            hideMode = "hidden";
            id = "ActiveWindow";
            maxWidth = 145;
            scrollingMode = "hover";
            showIcon = true;
            useFixedWidth = false;
          }
          {
            hideMode = "hidden";
            hideWhenIdle = false;
            id = "MediaMini";
            maxWidth = 145;
            scrollingMode = "hover";
            showAlbumArt = false;
            showArtistFirst = true;
            showProgressRing = true;
            showVisualizer = false;
            useFixedWidth = false;
            visualizerType = "linear";
          }
        ];
        right = [
          {
            id = "ScreenRecorder";
          }
          {
            blacklist = [ ];
            colorizeIcons = false;
            drawerEnabled = true;
            hidePassive = false;
            id = "Tray";
            pinned = [ ];
          }
          {
            hideWhenZero = false;
            id = "NotificationHistory";
            showUnreadBadge = true;
          }
          {
            deviceNativePath = "";
            displayMode = "onhover";
            hideIfNotDetected = true;
            id = "Battery";
            showNoctaliaPerformance = false;
            showPowerProfiles = false;
            warningThreshold = 30;
          }
          {
            displayMode = "onhover";
            id = "Volume";
          }
          {
            displayMode = "onhover";
            id = "Brightness";
          }
          {
            colorizeDistroLogo = false;
            colorizeSystemIcon = "none";
            customIconPath = "";
            enableColorization = false;
            icon = "noctalia";
            id = "ControlCenter";
            useDistroLogo = true;
          }
        ];
      };
    };
  };
}
