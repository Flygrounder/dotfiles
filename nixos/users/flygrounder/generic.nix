{ pkgs, ...}: 
let dotfiles = ../../../dotfiles;
  in
{
  home = {
    packages = with pkgs; [
      dmenu
      feh
      firefox
      (haskell.packages.ghc922.ghcWithPackages (p: [p.xmonad p.xmonad-contrib]))
      haskell-language-server
      neofetch
      nerdfonts
      yandex-disk
    ];
    username = "flygrounder";
    homeDirectory = "/home/flygrounder";
    stateVersion = "22.05";
  };
  xdg.dataFile = {
    wallpaper = {
      source = dotfiles + /wallpapers/nixos.png;
      target = "wallpaper.png";
    };
  };
  xsession.windowManager.xmonad = {
    enable = true;
    config = dotfiles + /xmonad/xmonad.hs;
    enableContribAndExtras = true;
    extraPackages = haskellPackages: with haskellPackages; [
      xmonad-contrib 
    ];
  };
  programs = {
    git = {
      enable = true;
      userEmail = "flygrounder@yandex.ru";
      userName = "Artyom Belousov";
    };
    kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;  
      };
      font = {
        name = "FiraCode Nerd Font";
        size = 12;
      };
      extraConfig = (builtins.readFile (dotfiles + /kitty/nord.conf));
    };
    fish = {
      enable = true;
      shellAliases = {
        rb = "sudo nixos-rebuild --flake /etc/nixos switch";
      };      
      functions = {
        fish_greeting = "";
      };
      interactiveShellInit = "fish_vi_key_bindings";
    };
    starship = {
      enable = true;
    };
    home-manager.enable = true;
    doom-emacs = {
      enable = true;
      doomPrivateDir = dotfiles + /doom.d;
    };
  };
}
