{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.vimiv;
  dotfiles = config.modules.config.dotfiles;
in
{
  options.modules.vimiv = {
    enable = mkOption {
      default = false;
      type = types.bool;
      description = "Enable vimiv image viewer";
    };
  };

  config = mkIf cfg.enable {
    xdg = {
      mimeApps = {
        enable = true;
        defaultApplications = {
          "image/png" = ["vimiv.desktop"];
          "image/gif" = ["vimiv.desktop"];
          "image/jpeg" = ["vimiv.desktop"];
        };
      };

      configFile.vimiv = {
        source = dotfiles + /vimiv/vimiv.conf;
        target = "vimiv/vimiv.conf";
      };
    };

    home.packages = with pkgs; [
      vimiv-qt
    ];
  };
}
