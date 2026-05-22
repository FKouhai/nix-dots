{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  imports = [
    ./features/desktops/hyprland
    ./features/bars
    ./features/prompt
    ./features/shelltools
    ./features/devtooling
    ./features/gtk
    ./features/terminals
    ./features/stylix
    ./features/flameshot.nix
    inputs.stylix.homeModules.stylix
    inputs.nixvim.homeModules.nixvim
    inputs.noctalia.homeModules.default
    inputs.tokyonight.homeManagerModules.default
  ];
  fonts.fontconfig.enable = true;

  age = {
    identityPaths = [ "/home/franky/.ssh/age" ];
    secrets = {
      ollama = {
        file = ../secrets/ollama.age;
        mode = "400";
      };
      gemini = {
        file = ../secrets/gemini.age;
        mode = "400";
      };
      grafana = {
        file = ../secrets/grafana.age;
        mode = "400";
      };
    };
  };

  home = {
    username = "franky";
    enableNixpkgsReleaseCheck = false;
    homeDirectory = "/home/franky";
    stateVersion = "24.11"; # Please read the comment before changing.
    sessionVariables = {
      OZONE_PLATFORM = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      EDITOR = "nvim";
      OPENCODE_DISABLE_AUTOUPDATE = true;
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
