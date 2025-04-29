{ inputs, pkgs, unstable-pkgs, flake-path, config, ... }:
let
  wsl-user = "groussin";
in
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    inputs.nixos-wsl.nixosModules.default
    ../../modules/nixos/nh.nix
  ];

  networking.hostName = "wsl";
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  users.users.${wsl-user} = {
    isNormalUser = true;
    description = "Guillaume Roussin";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager = {
    extraSpecialArgs = { 
      inherit inputs pkgs unstable-pkgs flake-path; 
      hostname = config.networking.hostName; 
    };
    backupFileExtension = "hm-backup";
  };

  home-manager.users.${wsl-user} = import ./home.nix;

  wsl = {
    enable = true;
    defaultUser = wsl-user;
    wslConf.network.hostname = "wsl";
    startMenuLaunchers = true;
  };

  environment.systemPackages = [
    pkgs.wget
    pkgs.lazydocker
    pkgs.ncdu
  ];

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ wsl-user ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
