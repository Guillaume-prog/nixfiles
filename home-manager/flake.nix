{
    description = "My Home Manager Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Add other flake inputs here as needed
        rycee-firefox-addons = { 
            # List addons : nix flake show gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons
            url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"; 
            inputs.nixpkgs.follows = "nixpkgs"; 
        };
    };

    outputs = {nixpkgs, home-manager, rycee-firefox-addons, ...}@inputs: 
    let 
        system = "x86_64-linux";
        inputs.firefox-addons = rycee-firefox-addons.packages.${system};

        # nixpkgs.config = {
        #     allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        #         "languagetool"
        #     ];
        # };
    in {
        homeConfigurations.guillaume = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs { inherit system; };
            extraSpecialArgs = { inherit inputs; };
            modules = [ ./home.nix ];
        };
    };
}