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

  outputs = inputs @ { self, nixpkgs, home-manager, nix-doom-emacs, ... }:
    let
      mkSystemConfig = host:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/${host}
            home-manager.nixosModules.home-manager
          ];
          specialArgs = { inherit inputs; };
        };
    in
      {
        nixosConfigurations = {
          laptop = mkSystemConfig "laptop";
          desktop = mkSystemConfig "desktop";
        };
      };
}
