{ xmobarTemplate }: { pkgs, ...}:
let dotfiles = ../../../dotfiles;
  in
{
  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };
    pointerCursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors-white";
      size = 32;
      x11.enable = true;
    };
    packages = with pkgs; [
      (haskell.packages.ghc922.ghcWithPackages (p: [p.xmonad p.xmonad-contrib]))
      acpi
      betterlockscreen
      binutils
      bpytop
      clang-tools
      cmatrix
      dconf
      direnv
      feh
      ffmpeg
      firefox
      font-awesome_5
      gcc
      ghostscript
      gimp
      gnumake
      go_1_18
      gopls
      graphicsmagick
      haskell-language-server
      libreoffice
      neofetch
      nerdfonts
      nodePackages.pyright
      nodePackages.typescript-language-server
      nodejs
      pandoc
      pcmanfm
      python3
      ripgrep
      roboto
      rustup
      scrot
      shellcheck
      tdesktop
      trayer
      ueberzug
      unzip
      vimiv-qt
      xclip
      xdotool
      yandex-disk
      zsh
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
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image/png" = ["vimiv.desktop"];
        "image/gif" = ["vimiv.desktop"];
        "image/jpeg" = ["vimiv.desktop"];
        "application/pdf" = ["org.pwmt.zathura.desktop"];
      };
    };
    dataFile = {
      lf-ueberzug = {
        source = dotfiles + /lf-ueberzug;
        target = "lf-ueberzug";
        recursive = true;
      };
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
      vimiv = {
        source = dotfiles + /vimiv/vimiv.conf;
        target = "vimiv/vimiv.conf";
      };
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
    neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        nord-vim
        vim-airline
      ];
      extraConfig = ''
      colorscheme nord'';
    };
    lf = {
      enable = true;
    };
    zathura = {
      enable = true;
      options = {
        default-bg = "#2E3440";
        default-fg = "#3B4252";
        statusbar-fg = "#D8DEE9";
        statusbar-bg = "#434C5E";
        inputbar-bg = "#2E3440";
        inputbar-fg = "#8FBCBB";
        notification-bg = "#2E3440";
        notification-fg = "#8FBCBB";
        notification-error-bg = "#2E3440";
        notification-error-fg = "#BF616A";
        notification-warning-bg = "#2E3440";
        notification-warning-fg = "#BF616A";
        highlight-color = "#EBCB8B";
        highlight-active-color = "#81A1C1";
        completion-bg = "#3B4252";
        completion-fg = "#81A1C1";
        completion-highlight-fg = "#8FBCBB";
        completion-highlight-bg = "#81A1C1";
        recolor-lightcolor = "#2E3440";
        recolor-darkcolor = "#ECEFF4";
        recolor = "false";
        recolor-keephue ="false";
      };
    };
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
        lf = "~/.local/share/lf-ueberzug/lf-ueberzug .";
        vim = "nvim";
      };      
      functions = {
        fish_greeting = "";
      };
      interactiveShellInit = ''fish_vi_key_bindings
direnv hook fish | source
fish_add_path $HOME/go/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin
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
       ,Run Com "/home/flygrounder/.local/share/scripts/battery.py" [ "format" ] "battery" 300
       ,Run Com "/home/flygrounder/.local/share/scripts/brightness.py" [] "brightness" 10
       ,Run Com "/home/flygrounder/.local/share/scripts/trayer-padding-icon.sh" [] "trayerpad" 10
      ]
  , sepChar     = "%"
  , alignSep    = "}{"
  , template    = "${xmobarTemplate}"
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
