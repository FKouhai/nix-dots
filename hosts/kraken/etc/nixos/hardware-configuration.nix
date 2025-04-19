# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "nfs"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/af2f8af9-f207-491a-8c3c-a734e7f2917e";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3095-1960";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  fileSystems."/data" = {
    device = "/dev/sdb1";
    fsType = "ext4";
  };

  fileSystems."/home/franky/games" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  fileSystems."/home/franky/games2" = {
    device = "/dev/sdc1";
    fsType = "ext4";
  };

  fileSystems."/mnt/NAS" = {
    device = "192.168.0.33:/mnt/user/Babylon";
    fsType = "nfs";
  };
  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp8s0.useDHCP = lib.mkDefault true;

  boot.supportedFilesystems = ["nfs"];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
