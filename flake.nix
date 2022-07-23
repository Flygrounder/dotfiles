{
  description = "flygrounder's system config";
  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
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

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, nix-doom-emacs, ... }:
    let
      unstableOverlay = self: super: {
        unstable = nixpkgs-unstable.legacyPackages.${self.system};
      };
      unstableOverlayModule = { config, pkgs, ... }: {
        nixpkgs.overlays = [ unstableOverlay ];
      };
      mkSystemConfig = host:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            unstableOverlayModule
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
