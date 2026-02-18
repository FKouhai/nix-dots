{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    tmux.enable = lib.mkEnableOption "Enable tmux module";
  };
  config = lib.mkIf config.tmux.enable {
    programs.tmux = {
      enable = true;
      keyMode = "vi";
      shortcut = "a";
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-strategy-vim "session"
            set -g @resurrect-strategy-nvim "session"
            set -g @resurrect-capture-pane-contents "on"
          '';
        }
        {
          plugin = tmux-fzf;
          extraConfig = ''
            set -g @plugin sainnhe/tmux-fzf
          '';
        }
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore "on"
            set -g @continuum-boot "on"
            set -g @continuum-save-interval "10"
          '';
        }
        better-mouse-mode
        harpoon
        {
          plugin = ukiyo;
          extraConfig = ''
            set -g @ukiyo-theme "kanagawa/wave"
            set -g @ukiyo-playerctl-format "►  {{ artist }} - {{ title }}"
            set -g @ukiyo-ignore-window-colors true
            set -g @ukiyo-refresh-rate 10
            set -g @ukiyo-show-battery false
            set -g @ukiyo-show-powerline true
            set -g @ukiyo-refresh-rate 10
          '';
        }
      ];
      extraConfig = ''
        bind-key h select-pane -L
        bind-key j select-pane -D
        bind-key k select-pane -U
        bind-key l select-pane -R
        set -g status "on"
        set -g mouse "on"
        set -g allow-passthrough on
        set-option -g status-position top
      '';
    };
  };
}
