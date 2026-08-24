{...}: {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  networking.hostName = "thinkpad";

  user.guillaume = {
    enable = true;
    home-config = ../../users/guillaume/home.nix;
  };

  # Keyboard layout
  keyboard.layout = "fr";

  my.software.docker.enable = true;
  my.software = {
    desktop.enable = true;
    media.enable = true;
    office.enable = true;
  };

  system.stateVersion = "25.11"; # Did you read the comment?
}
