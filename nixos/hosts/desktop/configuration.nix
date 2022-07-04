{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  time.timeZone = "Europe/Moscow";

  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.xmonad.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  programs.fish.enable = true;

  users.users.flygrounder = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  system.stateVersion = "22.05";

  nixpkgs.config.allowUnfree = true;
}
