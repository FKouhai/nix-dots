{pkgs, lib, config, ...}:
{

  options = {
    dap.enable = lib.mkEnableOption "Enable dap nixvim plugin module";
  };

  config = lib.mkIf config.dap.enable {
  programs.nixvim.plugins.dap = {
    enable = true;
    extensions = {
      dap-ui = {
        enable = true;
      };
      dap-go = {
        enable = true;
      };

    };
  };
 };
}
