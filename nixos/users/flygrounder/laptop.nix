{ pkgs, ...}: 
{
  imports = [
    (import ./generic.nix {
      xmobarTemplate =   " <fn=1>  </fn> %UnsafeXMonadLog% }{ <fn=2></fn> %kbd%    %brightness%    %battery%    %volume%    <fn=2></fn> %date%    %trayerpad%";
    })
  ];
}
