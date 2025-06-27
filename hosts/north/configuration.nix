{ ... }:

{
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  networking.hostName = "north";

  user.guillaume = {
    enable = true;
    home-config = ../../users/guillaume/home.nix;
  };

  user.lilou = {
    enable = true;
    home-config = ../../users/lilou/home.nix;
  };

  # Keyboard layout
  keyboard.layout = "fr";

  # Allow compiling for RPI
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

}
