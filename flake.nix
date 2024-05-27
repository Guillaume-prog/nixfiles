{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = { 
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"; 
      inputs.nixpkgs.follows = "nixpkgs"; 
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    unstable-pkgs = import inputs.nixpkgs-unstable { system = "x86_64-linux"; };
  in {
    nixosConfigurations.beelink = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs unstable-pkgs; };
      modules = [
        ./hosts/beelink/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
