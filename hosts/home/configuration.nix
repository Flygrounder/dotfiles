{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];
  networking.hostName = "home";
  services.greetd.enable = true;
  programs.regreet.enable = true;
  services.monero.enable = true;
  my.home.packages = with pkgs; [ furmark ];
  programs.corectrl.enable = true;
  users.users.flygrounder.extraGroups = [ "corectrl" ];
  users.users.dmitry = {
    isNormalUser = true;
    description = "Дмитрий";
    extraGroups = [ "networkmanager" ];
  };
  services.desktopManager.plasma6.enable = true;
  home-manager.users.dmitry.home = {
    username = "dmitry";
    homeDirectory = "/home/dmitry";
    stateVersion = "24.05";
    packages = with pkgs; [ brave libreoffice-still ];
  };
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.hardware.openrgb.enable = true;
  custom = {
    hyprland.enable = true;
    desktop.enable = true;
    cli.enable = true;
    hp-printer.enable = true;
    neovim.enable = true;
  };
}
