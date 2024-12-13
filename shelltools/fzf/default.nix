{pkgs, lib, config, ...}:
{

  options = {
    fzf.enable = lib.mkEnableOption "Enable fzf module";
  };

  config = lib.mkIf config.fzf.enable {
    programs.fzf = {
      enable = true;
      enableZshIntegration = false;
    };
  };

}

