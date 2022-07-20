{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.discord;
in
{
  options.modules.discord = {
    enable = mkOption {
      default = false;
      type = types.bool;
      description = "Enable discord";
    };
  };

  config = mkIf cfg.enable {
    modules.config.user = {
      xdg.configFile.discord = {
        text = ''{"SKIP_HOST_UPDATE": true}'';
        target = "discord/settings.json";
      };

      home.packages = with pkgs; [
        discord
      ];
    };
  };
}
