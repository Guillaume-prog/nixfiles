{...}: {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  networking.hostName = "north";

  user.guillaume = {
    enable = true;
    home-config = ../../users/guillaume/home.nix;
  };

  # Keyboard layout
  keyboard.layout = "fr";

  # enable GPU
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["amdgpu"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  my.gnome.autologin.user = "guillaume";
  my.samba.nas.enable = true;

  my.software.docker.enable = true;
  my.software = {
    desktop.enable = true;
    gaming.enable = true;
    media.enable = true;
    office.enable = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
