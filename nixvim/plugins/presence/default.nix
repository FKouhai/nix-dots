{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    presence.enable = lib.mkEnableOption "Enable presence nixvim plugin module";
  };

  config = lib.mkIf config.presence.enable {
    programs.nixvim.plugins.presence = {
      enable = true;
      settings = {
        neovim_image_text = "nvim";
      };
    };
  };
}
