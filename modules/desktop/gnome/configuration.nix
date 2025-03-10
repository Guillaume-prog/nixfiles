{ pkgs, lib, ... }: {

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable dconf to configure gnome in home-manager
  programs.dconf.enable = true;

  # enable i2c for brightness control
  hardware.i2c.enable = true;

  # enable bluetooth experimental settings for bluetooth gnome extension
  systemd.services.bluetooth.serviceConfig.ExecStart = lib.mkForce [
    "" # extra line to work around systemd's list concatenation shenanigans
    "${pkgs.bluez}/libexec/bluetooth/bluetoothd -f /etc/bluetooth/main.conf --experimental"
  ];

  # Desktop packages to include

  environment.systemPackages = with pkgs; [
    gedit
    gnome-extension-manager
    loupe # image viewer
    evince # document viewer
    snapshot # camera
    dconf2nix # useful for parsing dconf
    gnome-calculator
    gnome-calendar
    gnome-tweaks
    nautilus
    simple-scan
  ];

  # Desktop packages to exclude

  services.xserver.excludePackages = [ pkgs.xterm ];
  documentation.nixos.enable = false;

  environment.gnome.excludePackages = with pkgs; [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    geary
    gnome-characters
    gnome-console
    gnome-contacts
    gnome-initial-setup
    gnome-maps
    gnome-music
    gnome-photos
    gnome-shell-extensions
    gnome-software
    gnome-text-editor # email reader
    gnome-tour
    gnome-weather
    hitori # sudoku game
    iagno # go game
    tali # poker game
    totem # video player
    yelp # Help view
  ];
  
}
