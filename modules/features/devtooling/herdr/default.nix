{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    herdr.enable = lib.mkEnableOption "Enable tmux module";
  };
  config = lib.mkIf config.herdr.enable {
    programs.herdr = {
      enable = true;
      package = inputs.llm.packages.x86_64-linux.herdr;
      settings = {
        keys = {
          prefix = "ctrl+a";
          toggle_sidebar = "prefix+a";
          split_vertical = "prefix+%";
          detach = "prefix+d";
        };
        ui = {
          sound.enabled = false;
          sidebar_start_collapsed = true;
          sidebar_collapsed_mode = "hidden";
          toast = {
            delivery = "herdr";
            herdr.position = "top-right";
          };
        };
        theme = {
          name = "terminal";
        };
      };
    };
  };
}
