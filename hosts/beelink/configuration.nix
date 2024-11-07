{ ... }:

{

  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  networking.hostName = "beelink";

  user.guillaume = {
    enable = true;
    home-config = ./home.guillaume.nix;
  };



  # Keyboard layout
  keyboard.layout = "gb-extd";

  # Support for beelink bluetooth chip
  boot.initrd.kernelModules = [ "btintel" ];

}
