{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nur.url = "github:nix-community/nur";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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
    };

    unstable-pkgs = import inputs.nixpkgs-unstable { 
      inherit system; 
      config.allowUnfree = true;
    };

    create-system = name: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs pkgs unstable-pkgs flake-path; };
      modules = [ ./hosts/${name}/configuration.nix ];
    };
  in {
    nixosConfigurations = {
      beelink = create-system "beelink";
      asus = create-system "asus";
      wsl = create-system "wsl";
    };
  };
}
