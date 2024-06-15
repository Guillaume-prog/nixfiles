{ ... }: {

  imports = [
    ../../modules/home-manager
  ];

  desktop.gnome.wallpaper = {
    image = ./assets/background.png;
    primary = "#3771C8";
    secondary = "#000000";
  };

}
