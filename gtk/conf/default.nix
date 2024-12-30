{pkgs, lib, config, ...}:
{

  options = {
    gtk-conf.enable = lib.mkEnableOption "Enable gtk module";
  };

  config = lib.mkIf config.gtk-conf.enable {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Tokyonight-Dark";
      };
      theme = {
        name =  "Tokyonight-Dark";
      };
    };
 };
}
