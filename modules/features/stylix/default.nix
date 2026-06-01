{
  lib,
  config,
  pkgs,
  osConfig,
  vars,
  ...
}:
{
  options = {
    stylix-mod.enable = lib.mkEnableOption "Enable stylix module";
  };
  config = lib.mkIf config.stylix-mod.enable {
    stylix = {
      autoEnable = false;
      enable = true;
      inherit (osConfig.host.themeData) base16Scheme;
      targets = {
        bat.enable = true;
        btop.enable = true;
        gtk.enable = false;
        hyprland.enable = false;
        k9s.enable = true;
        kubecolor.enable = true;
        lazygit.enable = false;
        mpv.enable = true;
        opencode.enable = true;
        noctalia-shell.enable = false;
        vesktop.enable = true;
        wofi.enable = true;
      };
    };
  };
}
