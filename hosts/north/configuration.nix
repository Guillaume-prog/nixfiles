{ inputs, pkgs, ... }:

{
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
    inputs.jovian.nixosModules.default
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
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Bluetooth CM748 kernel patch: https://stackoverflow.com/a/79716173/10304753
  # ===============================
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  boot.kernelPatches = [{
    name = "cm748-patch";
    patch = ./cm748.patch;
  }];
  # ===============================

  virtualisation.docker.enable = true;
  users.users.guillaume.extraGroups = [ "docker" ];

  # my.htpc.enable = true;
  # my.htpc.user = "guillaume";

  # services.displayManager = {
  #   gdm.enable = true;
  #   autoLogin =  {
  #     enable = true;
  #     user = "guillaume";
  #   };
  # };

  jovian = {
    hardware.has.amd.gpu = true;
    steamos.useSteamOSConfig = true;
    steam = {
      updater.splash = "vendor";
      enable = true;
      autoStart = true;
      user = "guillaume";
      desktopSession = "gnome";
    };
  };

  environment.systemPackages = [ pkgs.plex-htpc ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
