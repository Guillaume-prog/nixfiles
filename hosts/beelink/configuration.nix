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

  user.lilou = {
    enable = true;
    home-config = ./home.lilou.nix;
  };

  # Keyboard layout
  keyboard.layout = "gb-extd";

  # Support for beelink bluetooth chip
  boot.initrd.kernelModules = [ "btintel" ];

  # Allow compiling for RPI
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

}
