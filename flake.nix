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

    catpuccin-grub = {
      url = "github:catppuccin/grub";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";

    allowed-unfree-packages = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
      "discord"
      "beeper"

      "steam"
      "steam-original"
      "steam-run"

      "languagetool"
      "cnijfilter2"
    ];

    pkgs = import nixpkgs { 
      inherit system; 
      config.allowUnfreePredicate = allowed-unfree-packages;
    };

    unstable-pkgs = import inputs.nixpkgs-unstable { 
      inherit system; 
      config.allowUnfreePredicate = allowed-unfree-packages;
    };
  in {
    nixosConfigurations = {

      beelink = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs pkgs unstable-pkgs; };
        modules = [ ./hosts/beelink/configuration.nix ];
      };

      asus = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs pkgs unstable-pkgs; };
        modules = [ ./hosts/asus/configuration.nix ];
      };

    };
  };
}
