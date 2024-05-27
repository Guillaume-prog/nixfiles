# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default

      ../../modules/nixos
    ];

    nixpkgs.config.allowUnfree = true; # Needs removing !!!
    networking.hostName = "beelink"; # Define your hostname.

    home-manager = {
      extraSpecialArgs = { inherit inputs; };
      users.guillaume = import ./home.nix;
      # backupFileExtension = "backup";
    };

}
