{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    lzn.enable = lib.mkEnableOption "Enable lzn nixvim plugin module";
  };

  config = lib.mkIf config.lzn.enable {
    programs.nixvim.plugins.lz-n = {
      enable = true;
    };
  };
}
