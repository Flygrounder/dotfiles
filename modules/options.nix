{ inputs, options, lib, config, ... }:
with lib;
{
  options.modules.config = {
    username = mkOption {
      type = types.str;
      default = "flygrounder";
      description = "Main user name";
    };
    user = mkOption {
      type = types.attrsOf types.anything;
      description = "User config";
    };
    dotfiles = mkOption {
      type = types.path;
      description = "Dotfiles directory location";
    };
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${config.modules.config.username} = mkAliasDefinitions options.modules.config.user;
      sharedModules = [
        inputs.nix-doom-emacs.hmModule
      ];
    };
  };
}
