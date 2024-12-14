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
  ./shelltools
  ./devtooling
  #./modules/desktop.nix
  ];
  # environment.
  home.packages = with pkgs; [
    vesktop
    bitwarden-cli
    bitwarden-desktop
    lazygit
    lazydocker
    docker
    gcc
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


  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  }
