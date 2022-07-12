{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../modules/common.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "desktop";
}
