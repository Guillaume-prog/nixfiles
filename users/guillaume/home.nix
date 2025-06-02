{ pkgs, hostname, unstable-pkgs, ... }:

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

  home.packages = (with pkgs; [
    orca-slicer
  ]) ++ (with unstable-pkgs; [
    cura-appimage
  ]);

  software = {
    anydesk.enable = true;
    beeper.enable = true;
    fragments.enable = true;

    discord.package = pkgs.vesktop;
  };

  software.gaming.enable = true;

  gnome.app-layout = import ./gnome.settings.nix;

  git.username = "Guillaume-prog";
  git.email = "76855158+Guillaume-prog@users.noreply.github.com";

}
