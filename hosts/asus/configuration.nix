{ ... }:

{
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  networking.hostName = "asus";
  home-manager.users.guillaume = import ./home.nix;

  # Keyboard layout
  keyboard.layout = "fr";
}
