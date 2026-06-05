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
      GTK_USE_PORTAL = "1";
      NIXOS_OZONE_WL = "1";
    };

    packages = import ./packages.nix { inherit pkgs; };
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 22;
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "yazi-open.desktop";
      "x-scheme-handler/itunes" = "Cider.desktop";
      "x-scheme-handler/music" = "Cider.desktop";
      "x-scheme-handler/cider" = "Cider.desktop";
      "x-scheme-handler/itms" = "Cider.desktop";
      "x-scheme-handler/itmss" = "Cider.desktop";
      "x-scheme-handler/cider2" = "Cider.desktop";
      "x-scheme-handler/discord" = "vesktop.desktop";
      "x-scheme-handler/http" = "helium.desktop";
      "x-scheme-handler/https" = "helium.desktop";
      "x-scheme-handler/chrome" = "zen-beta.desktop";
      "text/html" = "helium.desktop";
      "application/x-extension-htm" = "zen-beta.desktop";
      "application/x-extension-html" = "zen-beta.desktop";
      "application/x-extension-shtml" = "zen-beta.desktop";
      "application/xhtml+xml" = "zen-beta.desktop";
      "application/x-extension-xhtml" = "zen-beta.desktop";
      "application/x-extension-xht" = "zen-beta.desktop";
      "x-scheme-handler/about" = "helium.desktop";
      "x-scheme-handler/unknown" = "helium.desktop";
      "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
      "x-scheme-handler/tonsite" = "org.telegram.desktop.desktop";
      "x-scheme-handler/claude-cli" = "claude-code-url-handler.desktop";
    };
  };

  xdg.configFile."environment.d/wayland-session.conf".text = ''
    GTK_USE_PORTAL=1
    NIXOS_OZONE_WL=1
    OZONE_PLATFORM=wayland
    ELECTRON_OZONE_PLATFORM_HINT=wayland
    QT_QPA_PLATFORMTHEME=xdgdesktopportal
  '';

  # Custom modules
  prompt.enable = true;
  devtooling.enable = true;
  gleam.enable = false;
  lua.enable = false;
  shelltools.enable = true;
  stylix-mod.enable = true;
  gtk-mod.enable = true;
  gtk-conf.enable = true;
  hyprland.enable = true;
  terminals.enable = true;

  # Minimal programs configuration
  programs = {
    home-manager.enable = true;
    btop = {
      enable = true;
      settings = {
        theme_background = false;
        color_theme = "noctalia";
      };
    };
    git = {
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
