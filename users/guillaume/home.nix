{ pkgs, hostname, ... }:

{ 
  imports = [
    ../../modules/home-manager
  ];

  home = {
    username = "guillaume";
    homeDirectory = "/home/guillaume";
  };

  desktop.gnome.wallpaper = {
    image = ./background- + hostname + ".png";
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

  gnome.app-layout = import ./gnome.settings.nix;
}
