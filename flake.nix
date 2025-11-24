{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nur.url = "github:nix-community/nur";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alacritty-themes = {
      url = "github:alacritty/alacritty-theme";
      flake = false;
    };

    catpuccin-grub = {
      url = "github:catppuccin/grub";
      flake = false;
    };
  };

  outputs = { nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
    flake-path = "/nixfiles";

    pkgs = import nixpkgs { 
      inherit system; 
      overlays = [
        inputs.nur.overlays.default
      ];
      config.allowUnfree = true;
      config.allowUnfreePredicate = _: true;
    };

    unstable-pkgs = import inputs.nixpkgs-unstable { 
      inherit system; 
      config.allowUnfree = true;
      config.allowUnfreePredicate = _: true;
    };

    create-system = name: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs pkgs unstable-pkgs flake-path; };
      modules = [ 
        ./hosts/${name}/configuration.nix
        {
          imports = [
            inputs.nixpkgs.nixosModules.readOnlyPkgs
          ];

          nixpkgs.pkgs = pkgs;
        }
      ];
    };

    create-configurations = hostnames: builtins.listToAttrs (map (name: {
      name = name;
      value = create-system name;
    }) hostnames);
  in {
    nixosConfigurations = create-configurations [ "asus" "north" "wsl" "potato" "pavilion" ];
  };
}
