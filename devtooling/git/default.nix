{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    git.enable = lib.mkEnableOption "Enable git module";
  };

  config = lib.mkIf config.git.enable {
    programs = {

      git = {
        enable = true;
        package = pkgs.git;
        settings = {
          user = {
            name = "FKouhai";
            email = "frandres00@gmail.com";
            signingkey = "~/.ssh/bw.pub";
          };

          commit.gpgsign = true;
          gpg.format = "ssh";
          signing = {
            format = "ssh";
            key = "~/.ssh/bw.pub";
          };
        };
      };
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
      git-worktree-switcher.enable = true;
    };
  };
}
