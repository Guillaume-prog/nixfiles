{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    beeper
    obsidian
    
    gimp
    inkscape

    vesktop

    fritzing
    godot_4
    cura-appimage
  ];

}