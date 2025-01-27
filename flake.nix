{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    arion = {
      url = "github:hercules-ci/arion";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, home-manager, nixvim, arion, agenix, ... }:
    let
      system = "x86_64-linux";
      extraModules = [
        home-manager.nixosModules.home-manager
        ({ lib, ... }: {
          imports = [
            (lib.mkAliasOptionModule [ "my" ] [
              "home-manager"
              "users"
              "flygrounder"
            ])
          ];
          home-manager = {
            sharedModules = [ nixvim.homeManagerModules.nixvim ];
            useGlobalPkgs = true;
            useUserPackages = true;
            users.flygrounder = {
              programs.home-manager.enable = true;
              home = {
                username = "flygrounder";
                homeDirectory = "/home/flygrounder";
                stateVersion = "24.05";
              };
            };
          };
        })
        arion.nixosModules.arion
        agenix.nixosModules.default
        ./modules
      ];
    in {
      nixosConfigurations = let
        mkSystem = host:
          nixpkgs.lib.nixosSystem {
            inherit system;
            modules = extraModules ++ [ ./hosts/${host}/configuration.nix ];
          };
      in {
        home = mkSystem "home";
        laptop = mkSystem "laptop";
        nora = mkSystem "work";
      };
      colmena = {
        meta = {
          nixpkgs = import nixpkgs { inherit system; };
          specialArgs = { inherit extraModules; };
        };
        server = import ./hosts/server/configuration.nix;
      };
      devShells.${system}.default =
        let pkgs = import nixpkgs { inherit system; };
        in with pkgs;
        mkShell {
          buildInputs = [ colmena agenix.packages.${system}.default ];
        };
    };
}
