{
  self,
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
    ./hyprland
    ./prompt
    ./shelltools
    ./devtooling
    ./gtk
    ./terminals
    ./stylix
    ./flameshot.nix
    inputs.stylix.homeModules.stylix
    inputs.nixvim.homeModules.nixvim
    inputs.caelestia-shell.homeManagerModules.default
    inputs.noctalia.homeModules.default
    inputs.tokyonight.homeManagerModules.default
  ];
  fonts.fontconfig.enable = true;

  age = {
    identityPaths = [ "/home/franky/.ssh/age" ];
    secrets = {
      ollama = {
        file = ./secrets/ollama.age;
        mode = "400";
      };
      gemini = {
        file = ./secrets/gemini.age;
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
      "${config.xdg.configHome}/ghostty/theme".text = ''
        palette = 0=#12141c
        palette = 1=#4D5360
        palette = 2=#546876
        palette = 3=#BB6968
        palette = 4=#627985
        palette = 5=#708995
        palette = 6=#7C97A4
        palette = 7=#b9c6ce
        palette = 8=#818a90
        palette = 9=#4D5360
        palette = 10=#546876
        palette = 11=#BB6968
        palette = 12=#627985
        palette = 13=#708995
        palette = 14=#7C97A4
        palette = 15=#b9c6ce
        background = #12141c
        foreground = #b9c6ce
        cursor-color = #b9c6ce
        selection-background = #12141c
        selection-foreground = #b9c6ce
      '';
      "${config.xdg.configHome}/ghostty/config".text = ''
        theme = "${config.xdg.configHome}/ghostty/theme"
        background-opacity = 0.9
        window-decoration = false
        font-family = "Maple Mono NF"
      '';
    };

    sessionVariables = {
      OZONE_PLATFORM = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      EDITOR = "nvim";
    };

    packages = import ./packages.nix { inherit pkgs; };
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 22;
    };
  };

  # Custom modules
  prompt.enable = true;
  devtooling.enable = true;
  shelltools.enable = true;
  stylix-mod.enable = true;
  gtk-mod.enable = true;
  hyprland.enable = true;
  terminals.enable = true;

  # Minimal programs configuration
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
}
