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

  # Cursor size on x11 apps
  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Ice";
    XCURSOR_SIZE = "96";
  };
  
  # configure default applications for apps
  xdg.mime = {
    enable = true;

    defaultApplications = {
      # Image
      "image/jpeg" = [ "org.gnome.eog.desktop" ];
      "image/png"  = [ "org.gnome.eog.desktop" ];
      "image/gif"  = [ "org.gnome.eog.desktop" ];

      # Video
      "video/mp4"  = [ "org.gnome.Totem.desktop" ];
      "video/x-matroska" = [ "org.gnome.Totem.desktop" ];

      # Text
      "text/plain" = [ "org.gnome.gedit.desktop" ];

      # PDF
      "application/pdf" = [ "org.gnome.Evince.desktop" ];

      # Archives
      "application/zip"              = [ "org.gnome.FileRoller.desktop" ];
      "application/x-tar"            = [ "org.gnome.FileRoller.desktop" ];
      "application/x-bzip2"          = [ "org.gnome.FileRoller.desktop" ];
      "application/x-gzip"           = [ "org.gnome.FileRoller.desktop" ];
      "application/x-7z-compressed"  = [ "org.gnome.FileRoller.desktop" ];
      "application/x-rar"            = [ "org.gnome.FileRoller.desktop" ];
      "application/vnd.rar"          = [ "org.gnome.FileRoller.desktop" ];
      "application/x-archive"        = [ "org.gnome.FileRoller.desktop" ];

      # Audio
      "audio/mpeg"        = [ "org.gnome.Music.desktop" ]; # mp3
      "audio/flac"        = [ "org.gnome.Music.desktop" ];
      "audio/ogg"         = [ "org.gnome.Music.desktop" ];
      "audio/wav"         = [ "org.gnome.Music.desktop" ];
      "audio/x-wav"       = [ "org.gnome.Music.desktop" ];
      "audio/x-m4a"       = [ "org.gnome.Music.desktop" ];
      "audio/aac"         = [ "org.gnome.Music.desktop" ];
    };
  };

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
