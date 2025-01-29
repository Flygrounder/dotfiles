{ pkgs, lib, config, ... }: {
  options = { custom.cli.enable = lib.mkEnableOption "Enable CLI module"; };
  config = lib.mkIf config.custom.cli.enable {
    my = {
      home.packages = with pkgs; [ fastfetch bottom unzip ];
      programs = {
        git = {
          enable = true;
          extraConfig = { credential.helper = "store"; };
          userEmail = "flygrounder@yandex.ru";
          userName = "Artyom Belousov";
        };
        starship = {
          enable = true;
          settings = {
            format =
              "$directory$hostname$git_branch$git_commit$git_state$git_metrics$git_status$cmd_duration$line_break$character";
          };
        };
        fish = {
          enable = true;
          functions = { fish_greeting = ""; };
          shellAliases = { lg = "lazygit"; };
        };
        zoxide.enable = true;
        lazygit.enable = true;
        eza.enable = true;
        bat.enable = true;
      };
    };
    users.users.flygrounder.shell = pkgs.fish;
    programs = {
      fish.enable = true;
      direnv.enable = true;
    };
    my.home.sessionVariables = { EDITOR = "nvim"; };
  };
}
