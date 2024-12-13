# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, extra-types, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "franktory"; # Define your hostname.
  networking.search = ["home.universe.home"];
  networking.nameservers = ["192.168.0.2" "1.1.1.1"];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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
  services.blueman.enable = true;
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    sugarCandyNix = {
    enable = true;
    settings = {
      Background = lib.cleanSource ./wp2.jpg; 
      ScreenWidth = 1920;
      ScreenHeight = 1080;
      FormPosition = "left";
      HaveFormBackground = true;
      PartialBlur = true;

    };
   };
  };
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
#  font.packages = [ ... ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts)
	fonts.packages = [
	pkgs.nerd-fonts.hack
	];
  #fonts.packages = with pkgs; [ pkgs.nerdfonts ];
  users.users.franky = {
    isNormalUser = true;
    description = "franky";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    neovim
    nixfmt-rfc-style
    nixd

];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    inputs.zen-browser.packages."x86_64-linux".specific
  ];

  system.stateVersion = "24.11"; # Did you read the comment?

}
