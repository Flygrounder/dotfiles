{ pkgs, ...}: 
{
  imports = [
    ./generic.nix
  ];

  modules.xmobar.template =   " <fn=1>  </fn> %UnsafeXMonadLog% }{ <fn=2></fn> %kbd%    %brightness%    %battery%    %volume%    <fn=2></fn> %date%    %trayerpad%";

  systemd.user = {
    services = {
      batteryCheck = {
        Unit = {
          Description = "Alerts user if battery level is low";
        };

        Service = {
          Type = "simple";
          ExecStart = "/home/flygrounder/.local/share/scripts/battery.py alert";
          Environment = "PATH=${pkgs.python3}/bin:${pkgs.dunst}/bin:${pkgs.acpi}/bin";
        };
      };
    };
    timers = {
      batteryCheck = {
        Unit = {
          Description = "Runs battery check every 10 minutes";
        };

        Timer = {
          OnBootSec = "10min";
          OnUnitActiveSec = "10min";
        };

        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
  };
}
