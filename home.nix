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

  imports = [
    ./hypr.nix
    ./prompt
    ./nixvim
    ./shelltools
    ./devtooling
    ./gtk
    ./hyprpanel.nix
    inputs.stylix.homeModules.stylix
    inputs.tokyonight.homeManagerModules.default
  ];

  age = {
    identityPaths = [ "/home/franky/.ssh/age" ];
    secrets = {
      ollama = {
        file = ./secrets/ollama.age;
        mode = "400";
      };
    };
  };
  home = {
    username = "franky";
    enableNixpkgsReleaseCheck = false;
    homeDirectory = "/home/franky";
    stateVersion = "24.11"; # Please read the comment before changing.
    file = {
      "${config.xdg.configHome}/ghostty/config".text = ''
        theme = "Kanagawa Dragon"
        background-opacity = 0.9
        window-decoration = false
        font-family = "Hack Nerd Font"
      '';
    };

    sessionVariables = {
      OZONE_PLATFORM = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      # EDITOR = "emacs";
    };

    packages = with pkgs; [
      # jetbrains.goland
      age
      ags
      alejandra
      bind
      bitwarden-desktop
      brave
      btop
      bulletty
      cava
      coreutils
      cosmic-files
      cliphist
      dysk
      element-desktop
      exercism
      fastfetch
      fd
      ffmpeg
      fishPlugins.forgit
      gamemode
      gcc
      gh
      git-lfs
      gnome-keyring
      gnome-secrets
      gnome-themes-extra
      gowall
      gpgme
      gtk-engine-murrine
      gum
      hack-font
      heroic
      hubble
      hyprpanel
      hyprpaper
      hyprshot
      jetbrains-mono
      jq
      kanagawa-gtk-theme
      kanagawa-icon-theme
      lazydocker
      lazygit
      libnotify
      libnvidia-container
      lmstudio
      matugen
      mpv
      nitch
      nix-search-tv
      nixos-generators
      nvidia-docker
      nwg-look
      obsidian
      oci-cli
      opencloud-desktop
      opencode
      pavucontrol
      playerctl
      pulseaudio
      pulseaudio-ctl
      pulsemixer
      revive
      ripgrep
      sesh
      statix
      statping-ng
      telegram-desktop
      terraform-ls
      tflint
      tldr
      tmux
      tokyonight-gtk-theme
      treefmt
      vesktop
      vhs
      vulkan-tools
      wl-clipboard
      wlogout
      python3
      zed-editor
    ];
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 22;
    };
  };

  prompt.enable = true;
  devtooling.enable = true;
  shelltools.enable = true;
  programs = {
    home-manager.enable = true;
    btop = {
      enable = true;
      settings = {
        theme_background = false;
      };
    };
    git = {
      delta.tokyonight.enable = false;
      lfs.enable = true;
    };
    onlyoffice.enable = true;
    wofi.enable = false;

    fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "Hack Nerd Font";
          prompt = ''">    "'';
          lines = 20;
          width = 60;
          horizontal-pad = 40;
          vertical-pad = 16;
          inner-pad = 6;
        };
        colors = {
          background = "1e1e2efa";
          text = "19617813801";
          border = "#c4b28a";
        };
      };
    };
  };

  qt = {
    enable = false;
    platformTheme.name = "gtk";
    style.name = "kvantum";
  };
  stylix = {
    autoEnable = false;
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa-dragon.yaml";
    targets = {
      bat.enable = true;
      btop.enable = true;
      gtk.enable = false;
      hyprland.enable = true;
      k9s.enable = true;
      kubecolor.enable = true;
      lazygit.enable = true;
      mpv.enable = true;
      vesktop.enable = true;
      wofi.enable = true;
    };
  };
  nixvimcfg.enable = true;
  gtk-mod.enable = true;
}
