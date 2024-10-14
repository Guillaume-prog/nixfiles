# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, unstable-pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default

    ../../modules/nixos
  ];

  networking.hostName = "beelink"; # Define your hostname.

  home-manager = {
    extraSpecialArgs = { inherit inputs pkgs unstable-pkgs; };
    users.guillaume = import ./home.nix;
    # backupFileExtension = "backup";
  };

  # Bluetooth config
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  boot.initrd.kernelModules = [ "btintel" ];

  # Bootloader config
  bootloader.theme = "catpuccin-macchiato";

  # Keyboard layout
  keyboard.layout = {
    layout = "gb";
    variant = "extd";
  };
}
