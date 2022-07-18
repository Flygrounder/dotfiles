{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../generic.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "desktop";

  modules.xmobar.template =   " <fn=1>  </fn> %UnsafeXMonadLog% }{ <fn=2></fn> %kbd%    %volume%    <fn=2></fn> %date%    %trayerpad%";
}
