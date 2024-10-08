# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/8f3a182f-e10a-4116-b580-b20e176ac7c9";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-2b4800ba-5325-4a98-8d13-5f578aca6b6b".device =
    "/dev/disk/by-uuid/2b4800ba-5325-4a98-8d13-5f578aca6b6b";
  boot.initrd.luks.devices."luks-6640ad52-6718-48ec-b889-3b03be4aa039".device =
    "/dev/disk/by-uuid/6640ad52-6718-48ec-b889-3b03be4aa039";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6FDA-5EB3";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices =
    [{ device = "/dev/mapper/luks-6640ad52-6718-48ec-b889-3b03be4aa039"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
