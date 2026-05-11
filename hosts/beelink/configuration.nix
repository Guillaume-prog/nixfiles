{ pkgs, ... }:

{
imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  networking.hostName = "beelink";

  environment.systemPackages = with pkgs; [ nicotine-plus  beets ];
  
  user.guillaume = {
    enable = true;
    home-config = ../../users/guillaume/home.nix;
  };

  # Keyboard layout
  keyboard.layout = "fr";


  system.stateVersion = "25.11";
}