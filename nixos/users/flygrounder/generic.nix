{ pkgs, config, lib, ...}:
with lib;
let
  myLib = import ../../lib { inherit lib; };
in
{
  imports = myLib.mapModulesRec ../modules (v: v);

  modules = {
    betterlockscreen.enable = true;
    dunst.enable = true;
    config.dotfiles = ../../../dotfiles;
    emacs.enable = true;
    neovim.enable = true;
    shell.enable = true;
    kitty.enable = true;
    ranger.enable = true;
    vimiv.enable = true;
    xmobar.enable = true;
    xmonad.enable = true;
    zathura.enable = true;
  };

  home = {
    packages = with pkgs; [
      binutils
      colmena
      dconf
      firefox
      gcc
      gimp
      gnumake
      go_1_18
      imagemagick
      libreoffice
      nodejs
      pavucontrol
      pcmanfm
      python3
      rustup
      sqlite
      tdesktop
      yandex-disk
    ];
    username = "flygrounder";
    homeDirectory = "/home/flygrounder";
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
}
