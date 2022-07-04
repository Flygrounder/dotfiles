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
  {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
        modules = [
          ./nixos/hosts/desktop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.flygrounder = nixpkgs.lib.mkMerge [
              nix-doom-emacs.hmModule
              (import ./nixos/users/flygrounder/desktop.nix)
            ];
          }
        ];
      };
    }; 
  };
}
