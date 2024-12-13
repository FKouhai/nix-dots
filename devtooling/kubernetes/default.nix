{pkgs,lib,config, ...}:
{
  options = {
    kubernetes.enable = lib.mkEnableOption "Enable kubernetes option";
  };
  config = lib.mkIf config.kubernetes.enable {
    home.packages = with pkgs; [
      kubectl
    ];
    programs.k9s = 
      let
        k9s_file = "./skin.yaml";
      in 
      {
        enable = true;
        skins = {
         skin = k9s_file;
        };
    };
  };
}
