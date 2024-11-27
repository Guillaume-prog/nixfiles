{ pkgs, ... }:

{ 
  imports = [
    ../../modules/home-manager
  ];

  home = {
    username = "lilou";
    homeDirectory = "/home/lilou";
  };

  desktop.gnome.wallpaper = {
    image = ./background.jpg;
    primary = "#06282D";
    secondary = "#000000";
  };

  software.discord.package = pkgs.discord;
  software.gaming.enable = true;

  gnome.app-layout = import ./gnome.settings.nix;
}
