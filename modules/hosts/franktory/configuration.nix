_: {
  flake.nixosModules.franktory =
    {
      config,
      lib,
      pkgs,
      inputs,
      ...
    }:
    {
      nixpkgs.config.allowUnfree = true;

      host = {
        hostName = "franktory";
        isDesktop = false;
        class = "laptop";
        bar = "noctalia";
        greeter = "sddm";
        theme = "kanagawa-dragon";
        wallpaper = "${inputs.wallpapers.packages.x86_64-linux.default}/share/wallpapers/kanoxo-wave/call_of_the_night_2.jpg";
        mainMonitor = {
          name = "eDP-1";
          width = "1920";
          height = "1080";
          refresh = "60";
        };
        secondaryMonitor = {
          name = "HDMI-A-2";
          width = "1920";
          height = "1080";
          refresh = "60";
        };
      };

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
      };

      networking = {
        hostName = "franktory";
        search = [ "universe.home" ];
        nameservers = [
          "192.168.0.2"
          "1.1.1.1"
        ];
        wireless.enable = lib.mkDefault false;
        networkmanager.enable = true;
      };

      time.timeZone = "Europe/Madrid";
      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "es_ES.UTF-8";
        LC_IDENTIFICATION = "es_ES.UTF-8";
        LC_MEASUREMENT = "es_ES.UTF-8";
        LC_MONETARY = "es_ES.UTF-8";
        LC_NAME = "es_ES.UTF-8";
        LC_NUMERIC = "es_ES.UTF-8";
        LC_PAPER = "es_ES.UTF-8";
        LC_TELEPHONE = "es_ES.UTF-8";
        LC_TIME = "es_ES.UTF-8";
      };

      services = {
        blueman.enable = true;
        upower.enable = true;
        power-profiles-daemon.enable = true;
        tailscale.enable = true;
        openssh = {
          enable = true;
          settings = {
            UseDns = false;
            PasswordAuthentication = true;
          };
        };
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
        };
        xserver = {
          enable = false;
          xkb = {
            layout = "us";
            variant = "";
          };
        };
      };

      programs = {
        zsh.enable = true;
        hyprland = {
          enable = true;
          xwayland.enable = true;
        };
      };

      security.rtkit.enable = true;

      fonts = {
        packages = [
          pkgs.nerd-fonts.hack
          pkgs.maple-mono.NF-unhinted
          pkgs.maple-mono.truetype
          pkgs.noto-fonts-cjk-sans
        ];
        fontconfig.defaultFonts = {
          sansSerif = [
            "DejaVu Sans"
            "Noto Sans CJK JP"
          ];
          serif = [
            "DejaVu Serif"
            "Noto Serif CJK JP"
          ];
          monospace = [
            "DejaVu Sans Mono"
            "Noto Sans Mono CJK JP"
          ];
        };
      };

      users = {
        defaultUserShell = pkgs.fish;
        users.franky = {
          isNormalUser = true;
          description = "franky";
          extraGroups = [
            "networkmanager"
            "wheel"
            "plugdev"
          ];
        };
      };

      system.stateVersion = "24.11";
    };
}
