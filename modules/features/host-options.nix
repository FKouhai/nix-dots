{ lib, ... }:
{
  options.host = {
    greeter = lib.mkOption {
      type = lib.types.enum [
        "sddm"
        "greetd"
        "noctalia-greet"
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
