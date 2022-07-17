{
  description = "flygrounder's system config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-doom-emacs, ... }:
    let
      mkSystemConfig = { host, userConfigs }:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./nixos/hosts/${host}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users = userConfigs;
            }
          ];
        };
      flygrounderConfig = host: nixpkgs.lib.mkMerge [
        nix-doom-emacs.hmModule
        (import ./nixos/users/flygrounder/${host}.nix)
      ];
    in
      {
        nixosConfigurations = {
          laptop = mkSystemConfig {
            host = "laptop";
            userConfigs = {
              flygrounder = flygrounderConfig "laptop";
            };
          };
          desktop = mkSystemConfig {
            host = "desktop";
            userConfigs = {
              flygrounder = flygrounderConfig "desktop";
            };
          };
        };
      };
}
