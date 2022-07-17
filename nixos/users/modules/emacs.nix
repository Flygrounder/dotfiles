{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.emacs;
  dotfiles = ../../../dotfiles;
in
{
  options.modules.emacs = {
    enable = mkOption {
      default = false;
      type = types.bool;
      description = "Enable Doom Emacs text editor";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      clang-tools
      gopls
      haskell-language-server
      nodePackages.pyright
      nodePackages.typescript-language-server
      pandoc
      rust-analyzer
      shellcheck
    ];

    programs.doom-emacs = {
      enable = true;
      doomPrivateDir = dotfiles + /doom.d;
    };
  };
}
