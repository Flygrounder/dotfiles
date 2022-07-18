{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.neovim;
in
{
  options.modules.neovim = {
    enable = mkOption {
      default = false;
      type = types.bool;
      description = "Enable neovim text editor";
    };
  };

  config = mkIf cfg.enable {
    modules.config.user = {
      home.sessionVariables = {
        EDITOR = "nvim";
      };

      programs.neovim = {
        enable = true;
        plugins = with pkgs.vimPlugins; [
          nord-vim
          vim-airline
        ];
        extraConfig = ''
      colorscheme nord'';
      };
    };
  };
}
