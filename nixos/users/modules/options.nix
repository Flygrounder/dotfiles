{ lib, config, ... }:
with lib;
{
  options.modules.config = {
    dotfiles = mkOption {
      type = types.path;
      description = "Dotfiles directory location";
    };
  };
}
