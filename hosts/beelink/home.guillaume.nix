{ pkgs, ... }:

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

  software = {
    anydesk.enable = true;
    beeper.enable = true;
    cura.enable = true;
    fragments.enable = true;

    discord.package = pkgs.vesktop;
  };

  software.gaming.enable = true;
}
