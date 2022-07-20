{ lib, config, ... }:
with lib;
let
  cfg = config.modules.bluetooth;
in
{
  options.modules.bluetooth = {
    enable = mkOption {
      default = false;
      type = types.bool;
      description = "Enable bluetooth";
    };
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    modules.config.user = {
      services.blueman-applet.enable = true;
    };
  };
}
