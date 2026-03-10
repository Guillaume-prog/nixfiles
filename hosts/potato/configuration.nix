{ pkgs, config, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/sops.nix
    ../../modules/nixos/nh.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.hostName = "potato";
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
    cifs-utils
    fastfetch 
    vim 
    tree 
    lazydocker 
    python312 
  ];

  virtualisation.docker.enable = true;

  networking.extraHosts = ''
    192.168.1.200 nas.lan
    192.168.1.201 potato.lan # SELF
    192.168.1.202 home-assistant.lan
    192.168.1.203 3d-printer.lan
  '';

  # Mount the NAS share
  environment.etc."smb-credentials".source = config.sops.secrets."smb-credentials".path;

  fileSystems."/mnt/nas" = {
    device = "//nas.lan/media";
    fsType = "cifs";

    # Credentials
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=/etc/smb-credentials"];
  };

  system.stateVersion = "24.05";

}
