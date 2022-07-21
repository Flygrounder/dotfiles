{ lib, config, pkgs, ... }:
let
  myLib = import ../lib { inherit lib; };
in
{
  imports = myLib.mapModulesRec ../modules (v: v);

  virtualisation = {
    docker.enable = true;
    virtualbox.host.enable = true;
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "ru_RU.UTF-8";

  networking.networkmanager.enable = true;

  security.sudo.wheelNeedsPassword = false;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.${config.modules.config.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "vboxusers" "video" ];
  };

  system.stateVersion = "22.05";

  nixpkgs.config.allowUnfree = true;

  hardware.xpadneo.enable = true;

  modules = {
    betterlockscreen.enable = true;
    bluetooth.enable = true;
    discord.enable = true;
    dunst.enable = true;
    config.dotfiles = ../dotfiles;
    emacs.enable = true;
    firefox.enable = true;
    neovim.enable = true;
    shell.enable = true;
    steam.enable = true;
    kitty.enable = true;
    ranger.enable = true;
    vimiv.enable = true;
    xmobar.enable = true;
    xmonad.enable = true;
    zathura.enable = true;

    config.user = {
      home = {
        packages = with pkgs; [
          binutils
          brave
          colmena
          dconf
          gcc
          gimp
          gnumake
          go_1_18
          imagemagick
          libreoffice
          nodejs
          pavucontrol
          pcmanfm
          pokerth
          python3
          rustup
          sqlite
          tdesktop
          yandex-disk
        ];
        username = config.modules.config.username;
        homeDirectory = "/home/${config.modules.config.username}";
        stateVersion = "22.05";
      };
      programs = {
        git = {
          enable = true;
          userEmail = "flygrounder@yandex.ru";
          userName = "Artyom Belousov";
        };
        home-manager.enable = true;
      };
    };
  };
}
