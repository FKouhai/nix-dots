{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    fzf.enable = lib.mkEnableOption "Enable fzf module";
  };

  config = lib.mkIf config.fzf.enable {
    programs.fzf = {
      enable = true;
      tmux.enableShellIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      historyWidget.enable = false;
      colors = {
        bg = "-1";
        "bg+" = "#2A2A37";
        fg = "-1";
        "fg+" = "#DCD7BA";
        hl = "#938AA9";
        "hl+" = "#c4746e";
        header = "#b6927b";
        info = "#658594";
        pointer = "#7AA89F";
        marker = "#7AA89F";
        prompt = "#c4746e";
        spinner = "#8ea49e";
      };
    };
  };
}
