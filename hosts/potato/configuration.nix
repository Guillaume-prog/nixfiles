{ pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.hostName = "potato"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Headless mode
  services.xserver.enable = false;
  console.keyMap = "fr";

  # SSH
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [22];

  services.logind.lidSwitch = "ignore";

  users.users.lexi = {
    isNormalUser = true;
    description = "lexi";
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  environment.systemPackages = with pkgs; [ fastfetch vim tree lazydocker ];

  virtualisation.docker.enable = true;

  networking.extraHosts = ''
    192.168.1.200 nas.lan
    192.168.1.201 potato.lan # SELF
    192.168.1.202 home-assistant.lan
    192.168.1.203 3d-printer.lan
  '';

  system.stateVersion = "24.05";

}
