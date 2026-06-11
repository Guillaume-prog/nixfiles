{ pkgs, lib, ... }:

{
imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  networking.hostName = "beelink";

  # bootloader stuff
  boot.loader.grub.efiInstallAsRemovable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [ nicotine-plus  beets ];
  
  user.guillaume = {
    enable = true;
    home-config = ../../users/guillaume/home.nix;
  };

  services.displayManager = {
    gdm.enable = true;
    autoLogin =  {
      enable = true;
      user = "guillaume";
    };
  };

  # Keyboard layout
  keyboard.layout = "fr";


  system.stateVersion = "25.11";
}