{ ... }:

{ 
  imports = [
    ../../modules/home-manager
  ];

  desktop.gnome.wallpaper = {
    image = ./assets/background.png;
    primary = "#06282D";
    secondary = "#000000";
  };
}
