{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.xmobar;
in
{
  options.modules.xmobar = {
    enable = mkOption {
      default = false;
      type = types.bool;
      description = "Enable XMobar module";
    };
    template = mkOption {
      default = "";
      type = types.str;
      description = "XMobar template";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      acpi
      font-awesome_5
      nerdfonts
      roboto
      trayer
      xdotool
    ];

    programs.xmobar = {
      enable = true;
      extraConfig = ''
Config
  { font        = "xft:Roboto-12:bold"
  , additionalFonts = [
      "xft:FiraCode Nerd Font-16:regular"
      ,"xft:Font Awesome 5 Free Solid-12:regular"
      ,"xft:Font Awesome 5 Brands-12:regular"
    ]
  , bgColor     = "#3B4252"
  , fgColor     = "#ECEFF4"
  , position    = TopSize L 100 30
  , textOffset  = 22
  , textOffsets = [
      22
      ,22
      ,22
    ]
  , commands    =
      [
       Run UnsafeXMonadLog
       ,Run Date "%H:%M %d.%m.%Y" "date" 10
       ,Run Kbd [("us", "US"), ("ru", "RU")]
       ,Run Volume "default" "Master" ["-t", "<volume>%"] 10
       ,Run Com "/home/flygrounder/.local/share/scripts/volume.py" [] "volume" 10
       ,Run Com "/home/flygrounder/.local/share/scripts/battery.py" [ "format" ] "battery" 300
       ,Run Com "/home/flygrounder/.local/share/scripts/brightness.py" [] "brightness" 10
       ,Run Com "/home/flygrounder/.local/share/scripts/trayer-padding-icon.sh" [] "trayerpad" 10
      ]
  , sepChar     = "%"
  , alignSep    = "}{"
  , template    = "${cfg.template}"
                    }'';
    };
  };
}
