{
  lib,
  config,
  pkgs,
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
      base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa-dragon.yaml";
      targets = {
        bat.enable = true;
        btop.enable = true;
        gtk.enable = false;
        hyprland.enable = true;
        k9s.enable = true;
        kubecolor.enable = true;
        opencode.enable = true;
        lazygit.enable = true;
        mpv.enable = true;
        vesktop.enable = true;
        hyprpanel.enable = true;
        wofi.enable = true;
      };
    };
  };
}