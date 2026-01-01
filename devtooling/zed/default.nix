{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    zed.enable = lib.mkEnableOption "Enable zed module";
  };
  config = lib.mkIf config.zed.enable {
    programs= {
      zed-editor = {
        enable = true;
        userSettings = {
          vim_mode = true;
          terminal = {
            alternate_scroll = "off";
            blinking = "off";
            copy_on_select = false;
            dock = "bottom";
            detect_venv = {
              on = {
                directories = [
                  ".env"
                  "env"
                  ".venv"
                  "venv"
                ];
                activate_script = "default";
              };
            };
            env = {
              TERM = "ghostty";
            };
            font_family = "Hack Nerd Font";
            font_features = null;
            font_size = null;
            line_height = "comfortable";
            option_as_meta = false;
            button = false;
            shell = "system";
            #{
            #                    program = "zsh";
            #};
            toolbar = {
              title = true;
            };
            working_directory = "current_project_directory";
          };
        };
      };
      zed-editor-extensions = {
        enable = true;
        packages = with pkgs.zed-extensions; [
          nix
          ty
        ];
      };
    };
  };
}
