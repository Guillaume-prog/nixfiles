{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/nur";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wfetch = {
      url = "github:iynaix/wfetch";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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

      "anydesk"
      "anydesk-6.3.2"

      "languagetool"
      "languagetool-8.6.0"

      "anytype"
      "Anytype-0.41.1"
    ];

    pkgs = import nixpkgs { 
      inherit system; 
      overlays = [
        inputs.nur.overlay
      ];
      config.allowUnfree = true;
      # config.allowUnfreePredicate = allowed-unfree-packages;
    };

    unstable-pkgs = import inputs.nixpkgs-unstable { 
      inherit system; 
      config.allowUnfree = true;
      # config.allowUnfreePredicate = allowed-unfree-packages;
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
