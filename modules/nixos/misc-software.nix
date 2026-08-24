{ pkgs, lib, config, ... }: {

  environment.systemPackages = with pkgs; [
    cura-appimage
    
    beeper
    obsidian
    
    gimp
    inkscape

    vesktop
  ];

}