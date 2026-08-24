{
  pkgs,
  lib,
  ...
}: {
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

  # Keyboard layout
  keyboard.layout = "fr";

  my.gnome.autologin.user = "guillaume";
  my.software.gaming.enable = true;

  environment.systemPackages = [pkgs.plex-htpc];

  system.stateVersion = "25.11";
}
