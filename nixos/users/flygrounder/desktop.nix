{ pkgs, ...}: 
{
  imports = [
    (import ./generic.nix {
      xmobarTemplate =   " <fn=1>  </fn> %UnsafeXMonadLog% }{ <fn=2></fn> %kbd%    %volume%    <fn=2></fn> %date%    %trayerpad%";
    })
  ];
}
