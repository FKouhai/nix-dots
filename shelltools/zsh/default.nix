{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    zsh.enable = lib.mkEnableOption "Enable zsh module";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      autocd = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initContent = ''
        source <(kubectl completion zsh)
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
        source <(fzf --zsh)
        export GEMINI_API_KEY=$(cat ${config.age.secrets.gemini.path})
        export SSH_AUTH_SOCK=/home/franky/.bitwarden-ssh-agent.sock
      '';
      plugins = [
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
        {
          name = "fzf";
          src = pkgs.fzf-zsh;
        }
      ];

      shellAliases = {
        ll = "eza --icons --git --git-ignore --git -F -l";
        cat = "bat";
        ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
        hms = "home-manager switch";
        k = "kubectl";
        fzfcheckout = "git branch | fzf | xargs git checkout";
        rebuild = "sudo nixos-rebuild switch --flake ~/.config/home-manager";
        upgrade = "nix flake update --flake ~/.config/home-manager && sudo nixos-rebuild switch --flake ~/.config/home-manager --upgrade";
        cleanup = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 2d  && sudo nix-collect-garbage --delete-older-than 2d";
      };
      history = {
        expireDuplicatesFirst = true;
        ignoreSpace = true;
        save = 10000;
      };
    };
  };
}
