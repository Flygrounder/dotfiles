{ pkgs, ...}: 
{
  imports = [
    ./generic.nix
    ../modules/batteryCheck.nix
  ];

  modules = {
    batteryCheck.enable = true;
    xmobar.template =   " <fn=1>  </fn> %UnsafeXMonadLog% }{ <fn=2></fn> %kbd%    %brightness%    %battery%    %volume%    <fn=2></fn> %date%    %trayerpad%";
  };
}
