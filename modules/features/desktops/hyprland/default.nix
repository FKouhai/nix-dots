{
  lib,
  config,
  osConfig ? { },
  ...
}:
{
  imports = [
    ./hypr.nix
  ];

  options = {
    desktops.hyprland = {
      enable = lib.mkEnableOption "Enable hyprland desktop";

      monitors = lib.mkOption {
        type = lib.types.nullOr (
          lib.types.submodule {
            options = {
              main = lib.mkOption {
                type = lib.types.submodule {
                  options = {
                    name = lib.mkOption {
                      type = lib.types.str;
                      default = "";
                    };
                    width = lib.mkOption {
                      type = lib.types.str;
                      default = "1920";
                    };
                    height = lib.mkOption {
                      type = lib.types.str;
                      default = "1080";
                    };
                    refresh = lib.mkOption {
                      type = lib.types.str;
                      default = "60";
                    };
                  };
                };
                default = { };
              };
              secondary = lib.mkOption {
                type = lib.types.submodule {
                  options = {
                    name = lib.mkOption {
                      type = lib.types.str;
                      default = "";
                    };
                    width = lib.mkOption {
                      type = lib.types.str;
                      default = "1920";
                    };
                    height = lib.mkOption {
                      type = lib.types.str;
                      default = "1080";
                    };
                    refresh = lib.mkOption {
                      type = lib.types.str;
                      default = "60";
                    };
                  };
                };
                default = { };
              };
            };
          }
        );
        default = null;
      };

      bar = lib.mkOption {
        type = lib.types.nullOr (lib.types.enum [ "noctalia" ]);
        default = null;
      };

      wallpaper = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
      };
    };
  };

  config = lib.mkIf config.desktops.hyprland.enable {
    hypr.enable = lib.mkDefault true;
  };
}
