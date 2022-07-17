{ config, pkgs, ... }:

{
  virtualisation = {
    docker.enable = true;
    virtualbox.host.enable = true;
  };

  time.timeZone = "Europe/Moscow";

  networking.networkmanager.enable = true;

  security.sudo.wheelNeedsPassword = false;
  services.xserver = {
    enable = true;
    displayManager.lightdm = {
      enable = true;
      greeters.gtk.cursorTheme = {
        package = pkgs.capitaine-cursors;
        name = "capitaine-cursors-white";
        size = 32;
      };
    };
    windowManager.xmonad.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  programs.fish.enable = true;

  users.users.flygrounder = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "vboxusers" "video" ];
    shell = pkgs.fish;
  };

  system.stateVersion = "22.05";

  nixpkgs.config.allowUnfree = true;
}
