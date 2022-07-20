{ lib, config, ... }:
with lib;
let
  cfg = config.modules.steam;
in
{
  options.modules.steam = {
    enable = mkOption {
      default = false;
      type = types.bool;
      description = "Enable steam";
    };
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
