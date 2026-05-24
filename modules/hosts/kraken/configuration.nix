_: {
  flake.nixosModules.kraken =
    {
      pkgs,
      inputs,
      ...
    }:
    {
      nixpkgs.config.allowUnfree = true;
      nixpkgs.overlays = [
        inputs.nix-cachyos-kernel.overlays.pinned
        inputs.kanoxo.overlays.default
      ];

      host = {
        hostName = "kraken";
        isDesktop = true;
        class = "desktop";
        bar = "noctalia";
        greeter = "greetd";
        gpuType = "amd";
        theme = "kanagawa-aqua";
        wallpaper = "${inputs.wallpapers.packages.x86_64-linux.default}/share/wallpapers/kanagawa-dragon/call_of_the_night_2.jpg";
        mainMonitor = {
          name = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. GS27QA 24286B001135";
          width = "2560";
          height = "1440";
          refresh = "180";
        };
        secondaryMonitor = {
          name = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. GS27QA 24286B001081";
          width = "2560";
          height = "1440";
          refresh = "144";
        };
      };

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        plymouth.enable = true;
        kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v4;
        kernelParams = [
          "nvme_core.default_ps_max_latency_us=0"
        ];
      };

      systemd.services = {
        dhcpd.enable = false;
      };

      networking = {
        firewall.allowedTCPPorts = [
          22
          10767
        ];
        useDHCP = false;
        hostName = "kraken";
        search = [ "universe.home" ];
        nameservers = [
          "192.168.0.2"
          "192.168.0.1"
        ];
        interfaces.enp10s0.ipv4.addresses = [
          {
            address = "192.168.0.38";
            prefixLength = 24;
          }
        ];
        defaultGateway = {
          address = "192.168.0.1";
          interface = "enp10s0";
        };
        networkmanager = {
          enable = false;
          plugins = with pkgs; [ networkmanager-openvpn ];
        };
      };

      time.timeZone = "Europe/Madrid";
      i18n.defaultLocale = "en_US.UTF-8";

      services = {
        journald.extraConfig = "SystemMaxUse=50M";
        pulseaudio.enable = false;
        hardware.openrgb = {
          enable = true;
          motherboard = "amd";
        };
        openssh = {
          enable = true;
          ports = [ 22 ];
          settings = {
            PasswordAuthentication = true;
            UseDns = false;
            X11Forwarding = false;
          };
        };
        tailscale = {
          enable = true;
          useRoutingFeatures = "client";
        };
        rpcbind.enable = true;
        xserver = {
          enable = true;
          xkb = {
            layout = "us";
            variant = "";
          };
        };
        blueman.enable = true;
        pipewire = {
          enable = true;
          extraConfig = {
            pipewire = {
              "10-custom-latency.conf"."context.properties" = {
                "default.clock.min-quantum" = 256;
                "default.clock.quantum" = 1024;
                "api.alsa.headroom" = 1024;
              };
              "99-pcm2900c-loopback.conf"."context.modules" = [
                {
                  name = "libpipewire-module-loopback";
                  args = {
                    "node.name" = "pcm2900c-loopback";
                    "node.description" = "PCM2900C Loopback";
                    "auto.connect" = true;
                    "capture.props" = {
                      "node.target" = "alsa_input.usb-BurrBrown_from_Texas_Instruments_USB_AUDIO_CODEC-00.pro-input-0";
                      "media.class" = "Audio/Source";
                    };
                    "playback.props" = {
                      "node.passive" = true;
                      "media.class" = "Audio/Sink";
                    };
                  };
                }
              ];
            };
            pipewire-pulse."10-custom-latency.conf"."context.properties" = {
              "default.clock.min-quantum" = 256;
              "default.clock.quantum" = 1024;
            };
          };
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          wireplumber.enable = true;
        };
      };

      virtualisation = {
        docker.enable = true;
        libvirtd.enable = true;
      };

      xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-termfilechooser ];

      programs = {
        gpu-screen-recorder.enable = true;
        zsh.enable = true;
        nh.enable = true;
        firefox.enable = true;
        steam.enable = true;
        hyprland.enable = true;
        hyprland.xwayland.enable = true;
      };

      security = {
        rtkit.enable = true;
        pam.services.gdm.enableGnomeKeyring = true;
      };

      fonts = {
        packages = with pkgs; [
          nerd-fonts.hack
          noto-fonts-cjk-sans
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
        motd = ''

                    ▗▄▄▄       ▗▄▄▄▄    ▄▄▄▖
                    ▜███▙       ▜███▙  ▟███▛
                     ▜███▙       ▜███▙▟███▛
                      ▜███▙       ▜██████▛
               ▟█████████████████▙ ▜████▛     ▟▙
              ▟███████████████████▙ ▜███▙    ▟██▙
                     ▄▄▄▄▖           ▜███▙  ▟███▛
                    ▟███▛             ▜██▛ ▟███▛
                   ▟███▛               ▜▛ ▟███▛
          ▟███████████▛                  ▟██████████▙
          ▜██████████▛                  ▟███████████▛
                ▟███▛ ▟▙               ▟███▛
               ▟███▛ ▟██▙             ▟███▛
              ▟███▛  ▜███▙           ▝▀▀▀▀
              ▜██▛    ▜███▙ ▜██████████████████▛
               ▜▛     ▟████▙ ▜████████████████▛
                     ▟██████▙       ▜███▙
                    ▟███▛▜███▙       ▜███▙
                   ▟███▛  ▜███▙       ▜███▙
                   ▝▀▀▀    ▀▀▀▀▘       ▀▀▀▘
                   welcome!
        '';
        users.franky = {
          isNormalUser = true;
          description = "franky";
          extraGroups = [
            "networkmanager"
            "qemu-libvirtd"
            "libvirtd"
            "dialout"
            "audio"
            "disk"
            "wheel"
            "docker"
          ];
          packages = with pkgs; [
            nixfmt
            nixd
            openssl
            openssl.dev
            qemu
            qemu_kvm
            nfs-utils
            wireguard-tools
            kdePackages.qtmultimedia
          ];
        };
      };

      system.stateVersion = "24.11";
    };
}
