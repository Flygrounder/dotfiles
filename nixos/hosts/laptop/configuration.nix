{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../modules/common.nix
    ];

  powerManagement.cpuFreqGovernor = "schedutil";
  services = {
    tlp = {
      enable = true;
    };
    xserver = {
      displayManager.autoLogin = {
        enable = true;
        user = "flygrounder";
      };
      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };
    };
  };

  programs.light.enable = true;

  boot = {
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
      };
      efi.canTouchEfiVariables = true;
    };

    initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-label/CRYPTROOT";
        preLVM = true;
        allowDiscards = true;
      };
    };
  };

  networking.hostName = "laptop";
}
