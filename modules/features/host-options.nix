{ lib, ... }:
{
  options.host = {
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "The hostname of this machine.";
    };
    isDesktop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether this machine is a desktop.";
    };
    class = lib.mkOption {
      type = lib.types.enum [
        "laptop"
        "desktop"
      ];
      description = "The class of this machine.";
    };
    bar = lib.mkOption {
      type = lib.types.enum [
        "noctalia"
      ];
      description = "The desktop bar/panel to use.";
    };
    greeter = lib.mkOption {
      type = lib.types.enum [
        "sddm"
        "greetd"
      ];
      default = "greetd";
      description = "The display manager / greeter to use.";
    };
    gpuType = lib.mkOption {
      type = lib.types.enum [
        "amd"
        "nvidia"
        "none"
      ];
      default = "none";
      description = "GPU type for acceleration packages (amd=ROCm, nvidia=CUDA, none=CPU-only).";
    };
    theme = lib.mkOption {
      type = lib.types.enum [
        "kanagawa-dragon"
        "kanagawa-wave"
        "kanagawa-aqua"
      ];
      default = "kanagawa-dragon";
      description = "System color theme variant.";
    };
    themeData = lib.mkOption {
      type = lib.types.attrs;
      readOnly = true;
      description = "Computed theme values derived from host.theme. Set by nixosModules.themeData.";
    };
    wallpaper = lib.mkOption {
      type = lib.types.path;
      description = "Path to the wallpaper image.";
    };
    mainMonitor = lib.mkOption {
      type = lib.types.submodule {
        options = {
          name = lib.mkOption { type = lib.types.str; };
          width = lib.mkOption { type = lib.types.str; };
          height = lib.mkOption { type = lib.types.str; };
          refresh = lib.mkOption { type = lib.types.str; };
        };
      };
      description = "Primary monitor configuration.";
    };
    secondaryMonitor = lib.mkOption {
      type = lib.types.submodule {
        options = {
          name = lib.mkOption { type = lib.types.str; };
          width = lib.mkOption { type = lib.types.str; };
          height = lib.mkOption { type = lib.types.str; };
          refresh = lib.mkOption { type = lib.types.str; };
        };
      };
      description = "Secondary monitor configuration.";
    };
  };
}
