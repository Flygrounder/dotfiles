{ ... }: {
  imports = [ ./hardware-configuration.nix ];
  networking.hostName = "nora";
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  custom = {
    hyprland.enable = true;
    desktop.enable = true;
    cli.enable = true;
    neovim.enable = true;
  };
}
