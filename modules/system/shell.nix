{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.shell;
  dotfiles = config.modules.config.dotfiles;
in
{
  options.modules.shell = {
    enable = mkOption {
      default = false;
      type = types.bool;
      description = "Enable shell module";
    };
  };

  config = mkIf cfg.enable {
    programs.fish.enable = true;
    users.users.${config.modules.config.username}.shell = pkgs.fish;

    modules.config.user = {
      home.packages = with pkgs; [
        bat
        bpytop
        cmatrix
        direnv
        exa
        fd
        neofetch
        ripgrep
        tree
        unzip
      ];

      programs = {
        fish = {
          enable = true;
          shellAliases = {
            rb = "sudo nixos-rebuild --flake /etc/nixos switch";
            vim = "nvim";
            ls = "exa";
            cat = "bat";
            find = "fd";
            grep = "rg";
          };
          functions = {
            fish_greeting = "";
          };
          interactiveShellInit = ''fish_vi_key_bindings
direnv hook fish | source
fish_add_path $HOME/go/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin
'';
        };
        starship = {
          enable = true;
        };
      };

      xdg.configFile.bat = {
        source = dotfiles + /bat/config;
        target = "bat/config";
      };
    };
  };
}
