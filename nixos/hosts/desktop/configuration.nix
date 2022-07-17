{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../generic.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "desktop";
}
