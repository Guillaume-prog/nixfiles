{ pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/bootloader.nix
    ../../modules/nixos/nh.nix
    ../../modules/nixos/sops.nix
    ../../modules/nixos/samba.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  my.bootloader = {
    enable = true;
    bootMode = "legacy";
    device = "/dev/sda";
  };

  # Enable networking
  networking.hostName = "optiplex";
  networking.networkmanager.enable = true;

  # Headless mode
  services.xserver.enable = false;
  services.logind.settings.Login.HandleLidSwitch = "ignore";
  console.keyMap = "fr";

  # SSH
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [22];

  users.users.lexi = {
    isNormalUser = true;
    description = "lexi";
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  environment.systemPackages = with pkgs; [ 
    fastfetch 
    vim 
    tree 
    lazydocker 
    python3 
  ];

  virtualisation.docker.enable = true;

  networking.extraHosts = ''
    192.168.1.200 nas.lan
    192.168.1.201 potato.lan # SELF
    192.168.1.202 home-assistant.lan
    192.168.1.203 3d-printer.lan
  '';

  # Mount the NAS share
  my.samba.enable = true;

  system.stateVersion = "24.05";

}
