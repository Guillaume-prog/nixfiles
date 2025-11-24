{ ... }:

{
imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  # Bootloader.
  my.bootloader.bootMode = "legacy";
  my.bootloader.device = "/dev/sda";

  networking.hostName = "pavilion";
  
  user.guillaume = {
    enable = true;
    home-config = ../../users/guillaume/home.nix;
  };

  # Keyboard layout
  keyboard.layout = "fr";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}