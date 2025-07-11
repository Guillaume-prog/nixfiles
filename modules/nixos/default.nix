{ pkgs, inputs, unstable-pkgs, flake-path, config, ... }: {

  imports = [
    inputs.home-manager.nixosModules.default
    ../desktop/gnome/configuration.nix
    ./bootloader.nix
    ./localisation.nix
    ./fonts.nix
    ./iphone.nix
    ./keyboard.nix
    ./printer.nix
    ./samba.nix
    ./steam.nix
    ./syncthing.nix
    ./nh.nix
    ./users.nix
    ./screen-share.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  home-manager = {
    extraSpecialArgs = { 
      inherit inputs pkgs unstable-pkgs flake-path; 
      hostname = config.networking.hostName; 
    };
    backupFileExtension = "hm-backup";
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Bluetooth config
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.guillaume = {
    isNormalUser = true;
    description = "Guillaume";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    git
    vlc
    nmap
    ncdu
    mlocate
    usbutils
  ];

  environment.interactiveShellInit = ''
    alias nx-edit="codium ${flake-path}"
    alias nx-update="pushd ${flake-path};sudo nix flake update; nh os switch;popd"
  '';

  services.locate = {
    enable = true;
    package = pkgs.mlocate;
    localuser = null;
  };

  screen-share.enable = true;
  
  services.netbird = {
    enable = true;
    package = unstable-pkgs.netbird;
  };

}