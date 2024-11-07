{ ... }:

{ 
  imports = [
    ../../modules/home-manager
  ];

  home = {
    username = "guillaume";
    homeDirectory = "/home/guillaume";
  };

  desktop.gnome.wallpaper = {
    image = ./assets/background.png;
    primary = "#06282D";
    secondary = "#000000";
  };
}
