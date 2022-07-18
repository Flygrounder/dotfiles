{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.ranger;
  dotfiles = config.modules.config.dotfiles;
in
{
  options.modules.ranger = {
    enable = mkOption {
      default = false;
      type = types.bool;
      description = "Enable ranger file manager";
    };
  };

  config = mkIf cfg.enable {
    modules.config.user = {
      xdg.configFile = {
        rangerRc = {
          source = dotfiles + /ranger/rc.conf;
          target = "ranger/rc.conf";
        };
        rangerRifle = {
          source = dotfiles + /ranger/rifle.conf;
          target = "ranger/rifle.conf";
        };
        rangerScope = {
          source = dotfiles + /ranger/scope.sh;
          target = "ranger/scope.sh";
          executable = true;
        };
      };
      home.packages = with pkgs; [
        atool
        ffmpeg
        poppler_utils
        ranger
        ueberzug
      ];
    };
  };
}
