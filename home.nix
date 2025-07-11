{
  pkgs,
  lib,
  vars,
  config,
  inputs,
  ...
}:
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
    ./gtk
    ./hyprpanel.nix
    inputs.stylix.homeManagerModules.stylix
    inputs.tokyonight.homeManagerModules.default
  ];
  # environment.
  home.packages = with pkgs; [
    jetbrains.goland
    matugen
    solaar
    heroic
    vial
    hyprpanel
    gpgme
    pulseaudio-ctl
    pulseaudio
    pulsemixer
    sassc
    gnome-themes-extra
    fishPlugins.forgit
    gtk-engine-murrine
    treefmt
    alejandra
    markdown-oxide
    vhs
    dysk
    element-desktop
    virtualgl
    vulkan-tools
    nix-search-tv
    ffmpeg
    ttyd
    vesktop
    bitwarden-desktop
    lazygit
    lazydocker
    ripgrep
    gcc
    gowall
    jq
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
    exercism
    coreutils
    fd
    tokyonight-gtk-theme
    kanagawa-gtk-theme
    kanagawa-icon-theme
    tldr
    btop
    gamemode
    hubble
    brave
    telegram-desktop
    statping-ng
    revive
    terraform-ls
    tflint
    mpv
    plex-mpv-shim
    glava
    cosmic-files
    nixos-generators
    cava
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
  programs.git.delta.tokyonight.enable = false;
  programs.onlyoffice.enable = true;
  programs.wofi.enable = true;
  stylix = {
    autoEnable = false;
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa-dragon.yaml";
    targets = {
      k9s.enable = true;
      vesktop.enable = true;
      btop.enable = true;
      gtk.enable = true;
      kubecolor.enable = true;
      lazygit.enable = true;
      qt.enable = true;
      wofi.enable = true;
    };
  };
  nixvimcfg.enable = true;
  gtk-mod.enable = true;

  home.file = {
    "${config.xdg.configHome}/ghostty/config".text = ''
      theme = "Kanagawa Dragon"
      background-opacity = 0.9
      window-decoration = false
      font-family = "Hack Nerd Font"
    '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
