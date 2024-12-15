{ pkgs, lib, config, inputs, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "franky";
  home.enableNixpkgsReleaseCheck = false;
  home.homeDirectory = "/home/franky";

  home.stateVersion = "24.11"; # Please read the comment before changing.
  imports = [
  ./hypr.nix
  ./prompt
  ./nixvim
  ./shelltools
  ./devtooling
  ./keymaps.nix
  ./vimopts.nix
   inputs.nixvim.homeManagerModules.nixvim
  ];
  # environment.
  home.packages = with pkgs; [
    vesktop
    bitwarden-desktop
    lazygit
    lazydocker
    docker
    ripgrep
    gcc
    jq
    wofi
    wlogout
    hack-font
    playerctl
    tmux
    hyprshot
    pavucontrol
    wl-clipboard
    waybar
    jetbrains-mono
    fastfetch
    nwg-look
    ollama
    hyprpaper
    devbox
    bind
    ags
    libnotify
    hyprpanel
    exercism
    bitwarden-cli
    coreutils
  ];
  home.pointerCursor = {
  gtk.enable = true;
  package = pkgs.bibata-cursors;
  name = "Bibata-Modern-Ice";
  size = 22;
};
  prompt.enable = true;
  devtooling.enable = true;
  shelltools.enable = true;
  programs.nixvim = {
      enable = true;
      defaultEditor = true;
      luaLoader.enable = false;
      plugins = {
        nix = {
	  enable = true;
	};
        web-devicons = {
          enable = true;
        };
      };
      colorschemes = {
        kanagawa = {
	  enable = true;
          settings = {
            transparent = true;
            theme  = "wave";
        };
	};
      };
    };
  nixvimcfg.enable = true;


  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  }
