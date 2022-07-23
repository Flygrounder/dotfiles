{ inputs, pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.xmonad;
  dotfiles = config.modules.config.dotfiles;
in
{
  options.modules.xmonad = {
    enable = mkOption {
      default = false;
      type = types.bool;
      description = "Enable XMonad window manager";
    };
  };

  config = mkIf cfg.enable {
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

    modules.config.user = {
      xsession.windowManager.xmonad = {
        enable = true;
        config = dotfiles + /xmonad/xmonad.hs;
        enableContribAndExtras = true;
        extraPackages = haskellPackages: with haskellPackages; [
          xmonad-contrib
        ];
      };

      home = {
        packages = with pkgs; [
          (haskell.packages.ghc922.ghcWithPackages (p: [p.xmonad p.xmonad-contrib]))
          feh
          scrot
          roboto
          xclip
        ];
        pointerCursor = {
          package = pkgs.capitaine-cursors;
          name = "capitaine-cursors-white";
          size = 32;
          x11.enable = true;
        };
      };

      xdg = {
        dataFile = {
          wallpaper = {
            source = dotfiles + /wallpapers/nixos.png;
            target = "wallpaper.png";
          };
          scripts = {
            source = dotfiles + /scripts;
            target = "scripts";
            executable = true;
            recursive = true;
          };
        };
        configFile = {
          neofetch = {
            source = dotfiles + /neofetch/config.conf;
            target = "neofetch/config.conf";
          };
        };
      };

      gtk = {
        enable = true;
        theme = {
          package = pkgs.nordic;
          name = "Nordic";
        };
        iconTheme = {
          package = pkgs.zafiro-icons;
          name = "Zafiro-icons";
        };
      };

      services = {
        network-manager-applet.enable = true;
        picom.enable = true;
        udiskie.enable = true;
      };

      programs = {
        eww = {
          enable = true;
          configDir = dotfiles + /eww;
          package = pkgs.unstable.eww;
        };
        rofi = {
        enable = true;
        theme = dotfiles + /rofi/nord.rasi;
      };
      };
    };
  };
}
