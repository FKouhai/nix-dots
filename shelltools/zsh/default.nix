{pkgs, lib, config, ...}:
{

  options = {
    zsh.enable = lib.mkEnableOption "Enable zsh module";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
          source <(kubectl completion zsh)
          '';
      plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];

      shellAliases = {
        ll = "eza --icons --git --git-ignore --git -F -l";
        k = "kubectl";
        update = "sudo nixos-rebuild switch";
      };
      history = {
        expireDuplicatesFirst = true;
        ignoreSpace = true;
        save = 10000;
      };

    };
  };

}

