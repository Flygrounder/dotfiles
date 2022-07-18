{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.batteryCheck;
in
{
  options.modules.batteryCheck = {
    enable = mkOption {
      default = false;
      type = types.bool;
      description = "Enable battery check daemon";
    };
  };

  config = mkIf cfg.enable {
    modules.config.user = {
      home.packages = with pkgs; [
        acpi
        dunst
        python3
      ];
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
    };
  };
}
