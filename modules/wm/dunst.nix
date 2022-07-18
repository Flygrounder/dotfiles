{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.dunst;
in
{
  options.modules.dunst = {
    enable = mkOption {
      default = false;
      type = types.bool;
      description = "Enable dunst notification daemon";
    };
  };

  config = mkIf cfg.enable {
    modules.config.user = {
      services.dunst = {
        enable = true;
        settings = {
          global = {
            frame_width = 0;
            font = "Roboto 12";
            separator_height = 10;
            separator_color = "#00000000";
            padding = 10;
            foreground = "#2E3440";
          };
          urgency_low = {
            background = "#A3BE8C";
          };
          urgency_normal = {
            background = "#EBCB8B";
          };
          urgency_critical = {
            background = "#BF616A";
          };
        };
      };
      home.packages = with pkgs; [
        roboto
      ];
      services.picom.enable = true;
    };
  };
}
