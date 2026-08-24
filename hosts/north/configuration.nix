{
  pkgs,
  lib,
  ...
}: {
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
  my.software.desktop = {
    enable = true;
    media.enable = true;
    office.enable = true;
  };

  programs.steam = lib.mkForce {
    enable = true;
    package = pkgs.steam.override {
      extraLibraries = p:
        with p; [
          libGL
        ];
    };
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
