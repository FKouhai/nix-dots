{pkgs, lib, config, ...}:
{

  options = {
    git.enable = lib.mkEnableOption "Enable git module";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      package = pkgs.git;
      userName = "FKouhai";
      userEmail = "frandres00@gmail.com";
    };

  };

}
