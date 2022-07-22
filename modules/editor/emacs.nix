{ inputs, pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.emacs;
  dotfiles = config.modules.config.dotfiles;
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
    modules.config.user = {
      programs.doom-emacs = {
        enable = true;
        doomPrivateDir = dotfiles + /doom.d;
      };
      home.packages = with pkgs;
          [
            biber
            clang-tools
            gopls
            haskell-language-server
            nerdfonts
            nodePackages.pyright
            nodePackages.typescript-language-server
            pandoc
            rust-analyzer
            shellcheck
            texlab
            (texlive.combine {
              inherit (texlive)
                scheme-medium
                collection-langcyrillic
                hyphenat;
            })
          ];
    };
  };
}
