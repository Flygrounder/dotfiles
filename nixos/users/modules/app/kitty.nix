{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.kitty;
  dotfiles = config.modules.config.dotfiles;
in
{
  options.modules.kitty = {
    enable = mkOption {
      default = false;
      type = types.bool;
      description = "Enable kitty terminal";
    };
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
        window_padding_width = 4;
      };
      font = {
        name = "FiraCode Nerd Font";
        size = 12;
      };
      extraConfig = (builtins.readFile (dotfiles + /kitty/nord.conf));
    };
    home.packages = with pkgs; [
      nerdfonts
    ];
  };
}
