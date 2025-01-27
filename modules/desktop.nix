{ pkgs, lib, config, ... }: {
  options = {
    custom.desktop.enable = lib.mkEnableOption "Enable desktop module";
  };
  config = lib.mkIf config.custom.desktop.enable {
    users.users.flygrounder = {
      isNormalUser = true;
      description = "Артём";
      extraGroups =
        [ "networkmanager" "wheel" "docker" "video" "adbusers" "vboxusers" ];
    };
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    security.sudo.wheelNeedsPassword = false;
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    programs.amnezia-vpn.enable = true;
    my.home.packages = with pkgs; [
      beekeeper-studio
      brave
      corefonts
      insomnia
      jetbrains.idea-community
      kubectl
      lens
      libreoffice-still
      mkvtoolnix-cli
      nextcloud-client
      pavucontrol
      thunderbird
      qbittorrent
      telegram-desktop
      vistafonts
      vlc
      zoom-us
    ];
    virtualisation.virtualbox.host.enable = true;
    nixpkgs.config.allowUnfree = true;
    networking.firewall.enable = false;
    system.stateVersion = "24.05";
    hardware.graphics.enable = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    virtualisation.docker.enable = true;
    time.timeZone = "Europe/Moscow";
    i18n.defaultLocale = "ru_RU.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
    networking.networkmanager.enable = true;
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    programs.adb.enable = true;
    programs.steam.enable = true;
  };
}
