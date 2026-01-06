{
  lib,
  pkgs,
  vars,
  config,
  inputs,
  ...
}:
{
  options = {
    bars.caelestia.enable = lib.mkEnableOption "Enable Caelestia bar";
  };
  config = lib.mkIf config.bars.caelestia.enable {
    programs = {
      caelestia = {
        enable = true;
        systemd = {
          enable = true;
          target = "graphical-session.target";
        };
        settings = {
          bar = {
            status = {
              showBattery = if !vars.isDesktop then true else false;
              showAudio = true;
              showNetwork = true;
            };
            entries = [
              {
                id = "logo";
                enabled = true;
              }
              {
                id = "workspaces";
                enabled = true;
              }
              {
                id = "activeWindow";
                enabled = false;
              }
              {
                id = "spacer";
                enabled = true;
              }
              {
                id = "tray";
                enabled = true;
              }
              {
                id = "clock";
                enabled = true;
              }
              {
                id = "statusIcons";
                enabled = true;
              }
              {
                id = "power";
                enabled = true;
              }
            ];
          };
          appearance = {
            font = {
              family = {
                clock = "Maple Mono NF";
                mono = "Maple Mono NF";
                sans = "Maple Mono NF";
              };
            };

            transparency = {
              enabled = true;
              base = 0.20;
              layers = 0.4;
            };
          };
          general = {
            apps = {
              terminal = [
                "ghostty"
              ];
              explorer = [
                "cosmic-files"
              ];
            };
          };
          launcher.maxWallpapers = 50;
          paths.wallpaperDir = "${inputs.wallpapers}/kanagawa-dragon/";
          services = {
            defaultPlayer = "Cider";
            useFarenheit = false;
            useTwelveHourClock = false;
          };
        };
        cli = {
          enable = true;
          settings = {
            theme.enableGtk = false;
          };
        };
      };
    };
  };
}