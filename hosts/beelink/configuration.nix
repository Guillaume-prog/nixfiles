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

  my.samba.enable = true;
  my.software.media.enable = true;

  system.stateVersion = "25.11";
}