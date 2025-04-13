{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    git.enable = lib.mkEnableOption "Enable git module";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      package = pkgs.git;
      userName = "FKouhai";
      userEmail = "frandres00@gmail.com";
      delta = {
        enable = true;
        options = {
          decorations = {
            commit-decoration-style = "bold yellow box ul";
            file-style = "bold yellow ul";
            file-decoration-style = "none";
            hunk-header-decoration-style = "yellow box";
          };
          interactive = {
            keep-plus-minus-markers = true;
          };
          features = "decorations";
        };
      };
      signing = {
        format = "ssh";
        key = "~/.ssh/id_ed25519.pub";
      };
    };
  };
}
