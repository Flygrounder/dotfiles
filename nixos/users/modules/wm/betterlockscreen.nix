{ lib, config, ... }:
with lib;
let
  cfg = config.modules.betterlockscreen;
in
{
  options.modules.betterlockscreen = {
    enable = mkOption {
      default = false;
      type = types.bool;
      description = "Enable betterlockscreen lock screen";
    };
  };

  config = mkIf cfg.enable {
    services = {
      betterlockscreen = {
        enable = true;
        arguments = [
          "-l"
          "~/.local/share/wallpaper.png"
          "--"
          "--ring-color"
          "#ECEFF4"
          "--keyhl-color"
          "#5e81ac"
          "--insidewrong-color"
          "#BF616A"
        ];
        inactiveInterval = 10;
      };
      screen-locker.enable = true;
    };
  };
}
