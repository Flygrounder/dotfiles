{ pkgs, ...}: 
let dotfiles = ../../../dotfiles;
  in
{
  home = {
    pointerCursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors-white";
      size = 32;
      x11.enable = true;
    };
    packages = with pkgs; [
      (haskell.packages.ghc922.ghcWithPackages (p: [p.xmonad p.xmonad-contrib]))
      betterlockscreen
      bpytop
      dconf
      direnv
      feh
      firefox
      font-awesome_5
      gimp
      go
      gopls
      haskell-language-server
      libreoffice
      neofetch
      nerdfonts
      nodePackages.pyright
      nodePackages.typescript-language-server
      nodejs
      pcmanfm
      python3
      ranger
      roboto
      shellcheck
      tdesktop
      trayer
      xdotool
      yandex-disk
    ];
    username = "flygrounder";
    homeDirectory = "/home/flygrounder";
    stateVersion = "22.05";
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
  xdg.dataFile = {
    wallpaper = {
      source = dotfiles + /wallpapers/nixos.png;
      target = "wallpaper.png";
    };
    volume = {
      source = dotfiles + /scripts/volume.py;
      target = "scripts/volume.py";
      executable = true;
    };
    trayerPadding = {
      source = dotfiles + /scripts/trayer-padding-icon.sh;
      target = "scripts/trayer-padding-icon.sh";
      executable = true;
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
        window_padding_width = 4;
      };
      font = {
        name = "FiraCode Nerd Font";
        size = 12;
      };
      extraConfig = (builtins.readFile (dotfiles + /kitty/nord.conf));
    };
    rofi = {
      enable = true;
      theme = dotfiles + /rofi/nord.rasi;
    };
    fish = {
      enable = true;
      shellAliases = {
        rb = "sudo nixos-rebuild --flake /etc/nixos switch";
      };      
      functions = {
        fish_greeting = "";
      };
      interactiveShellInit = ''fish_vi_key_bindings
direnv hook fish | source
'';
    };
    starship = {
      enable = true;
    };
    home-manager.enable = true;
    doom-emacs = {
      enable = true;
      doomPrivateDir = dotfiles + /doom.d;
    };
    xmobar = {
      enable = true;
      extraConfig = ''
Config
  { font        = "xft:Roboto-12:bold"
  , additionalFonts = [
      "xft:FiraCode Nerd Font-16:regular"
      ,"xft:Font Awesome 5 Free Solid-12:regular"
      ,"xft:Font Awesome 5 Brands-12:regular"
    ]
  , bgColor     = "#3B4252"
  , fgColor     = "#ECEFF4"
  , position    = TopSize L 100 30
  , textOffset  = 22
  , textOffsets = [
      22
      ,22
      ,22
    ]
  , commands    =
      [
       Run UnsafeXMonadLog
       ,Run Date "%H:%M %d.%m.%Y" "date" 10
       ,Run Kbd [("us", "US"), ("ru", "RU")]
       ,Run Volume "default" "Master" ["-t", "<volume>%"] 10
       ,Run Com "/home/flygrounder/.local/share/scripts/volume.py" [] "volume" 10
       ,Run Com "/home/flygrounder/.local/share/scripts/trayer-padding-icon.sh" [] "trayerpad" 10
      ]
  , sepChar     = "%"
  , alignSep    = "}{"
  , template    = " <fn=1>  </fn> %UnsafeXMonadLog% }{ %volume%    <fn=2></fn> %kbd%    <fn=2></fn> %date%    %trayerpad%"
  }'';
    };
  };
  services = {
    udiskie.enable = true;
    screen-locker.enable = true;
    betterlockscreen = {
      enable = true;
      arguments = [
        "-l"
        "~/.local/share/wallpaper.png"
        "--"
        "--ring-color"
        "#ECEFF4"
        "--keyhl-color"
        "#5e81ac"
        "--insidewrong-color"
        "#BF616A"
      ];
      inactiveInterval = 10;
    };
    network-manager-applet.enable = true;
    picom.enable = true;
    dunst = {
      enable = true;
      settings = {
        global = {
          frame_width = 0;
          font = "Roboto 12";
          separator_height = 10;
          separator_color = "#00000000";
          padding = 10;
          foreground = "#2E3440";
        };
        urgency_low = {
          background = "#A3BE8C";
        };
        urgency_normal = {
          background = "#EBCB8B";
        };
        urgency_critical = {
          background = "#BF616A";
        };
      };
    };
  };
}
