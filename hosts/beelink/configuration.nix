{ ... }:

{
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  networking.hostName = "beelink";
  home-manager.users.guillaume = import ./home.nix;

  # Keyboard layout
  keyboard.layout = "gb-extd";

  # Support for beelink bluetooth chip
  boot.initrd.kernelModules = [ "btintel" ];
}
