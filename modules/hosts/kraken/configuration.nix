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
        greeter = "noctalia-greet";
        gpuType = "amd";
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
        kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
        extraModulePackages = [
          (pkgs.linuxPackagesFor pkgs.cachyosKernels.linuxPackages-cachyos-latest.kernel).r8125
        ];
        # r8169 incorrectly binds to the RTL8125 2.5GbE NIC; r8125 is the proper driver
        blacklistedKernelModules = [ "r8169" ];
        kernelModules = [ "r8125" ];
        kernelParams = [
          "nvme_core.default_ps_max_latency_us=0"
          "libata.force=4:norst"
        ];
      };

      boot.kernel.sysctl = {
        "net.core.netdev_max_backlog" = 5000;
        "net.core.netdev_budget" = 600;
        "net.core.netdev_budget_usecs" = 8000;
        "net.core.rps_sock_flow_entries" = 32768;
      };

      services.irqbalance.enable = true;

      systemd.services = {
        dhcpd.enable = false;
        rps-enp10s0 = {
          description = "Enable RPS for enp10s0";
          after = [ "network.target" ];
          wantedBy = [ "multi-user.target" ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStart = "${pkgs.bash}/bin/bash -c 'echo ffff > /sys/class/net/enp10s0/queues/rx-0/rps_cpus && echo 2048 > /sys/class/net/enp10s0/queues/rx-0/rps_flow_cnt'";
          };
        };

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
          enable = false;
          xkb = {
            layout = "us";
            variant = "";
          };
        };
        blueman.enable = true;
        pipewire = {
          enable = true;
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

      hardware = {
        i2c.enable = true;
      };

      xdg.portal = {
        extraPortals = [ pkgs.xdg-desktop-portal-termfilechooser ];
        config.common."org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };

      programs = {
        zsh.enable = true;
        nh.enable = true;
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
            "plugdev"
            "i2c"
            "video"
          ];
          packages = with pkgs; [
            openssl
            nfs-utils
            wireguard-tools
          ];
        };
      };

      system.stateVersion = "24.11";
    };
}
