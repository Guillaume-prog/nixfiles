{hostname, ...}: {
  imports = [
    ../../modules/home-manager
  ];

  home = {
    username = "guillaume";
    homeDirectory = "/home/guillaume";
  };

  my.desktop.gnome = let
    host-path = ../../hosts/${hostname};
  in {
    wallpaper = {
      image = "${host-path}/background.png";
      primary = "#06282D";
      secondary = "#000000";
    };
    app-layout = import "${host-path}/gnome.settings.nix";
  };
}
