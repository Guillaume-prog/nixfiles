{ ... }:

{ 
  imports = [
    ../../modules/home-manager
  ];

  home = {
    username = "lilou";
    homeDirectory = "/home/lilou";
  };

  desktop.gnome.wallpaper = {
    image = ./assets/background.png;
    primary = "#06282D";
    secondary = "#000000";
  };
}
