{ pkgs, config, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/sops.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.hostName = "potato";
  networking.networkmanager.enable = true;

  # Headless mode
  services.xserver.enable = false;
  services.logind.lidSwitch = "ignore";
  console.keyMap = "fr";

  # SSH
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [22];

  users.users.lexi = {
    isNormalUser = true;
    description = "lexi";
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  environment.systemPackages = with pkgs; [ fastfetch vim tree lazydocker python312 ];

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
    device = "//192.168.1.200/media";
    fsType = "cifs";

    # Credentials
    options = [
      "credentials=/etc/smb-credentials"
      "noauto"                  # don't try mounting immediately at boot
      "nofail"                  # boot continues even if mount fails
      "_netdev"                 # mark as network device, waits for network
      "vers=3.0"                # (optional) specify SMB version
    ];
  };

  system.stateVersion = "24.05";

}
