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

  # enable GPU
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics = {
  enable = true;
  enable32Bit = true;
};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
