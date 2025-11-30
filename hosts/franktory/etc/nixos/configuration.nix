# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  lib,
  extra-types,
  pkgs,
  inputs,
  ...
}:
let
  sddm-astronaut = pkgs.sddm-astronaut.overrideAttrs (oldAttrs: {
    embeddedTheme = "japanese_aesthetic";
  });
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "franktory"; # Define your hostname.
    search = [ "universe.home" ];
    nameservers = [
      "192.168.0.2"
      "1.1.1.1"
    ];
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    # Enable networking
    networkmanager.enable = true;
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
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

  # Configure keymap in X11
  services = {
    blueman.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = lib.mkForce "sddm-astronaut-theme";
      extraPackages = with pkgs; [
        sddm-astronaut
      ];
      settings = {
        Theme = {
          Current = "sddm-astronaut-theme";
        };
      };
    };
    tailscale = {
      enable = true;
    };
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
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };

    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };
  virtualisation.qemu = {
    package = pkgs.qemu;
  };

  programs = {
    zsh.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  #  font.packages = [ ... ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts)
  fonts.packages = [
    pkgs.nerd-fonts.hack
    pkgs.maple-mono.NF-unhinted
    pkgs.maple-mono.truetype
  ];
  #fonts.packages = with pkgs; [ pkgs.nerdfonts ];
  users = {
    defaultUserShell = pkgs.zsh;
    users.franky = {
      isNormalUser = true;
      description = "franky";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages = with pkgs; [
        nixfmt-rfc-style
        nixd
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    tailscale
    sddm-astronaut
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}
