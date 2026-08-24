{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.software.desktop.enable = lib.mkEnableOption "Software used on desktop machines";

  config = lib.mkIf config.my.software.desktop.enable {
    environment.systemPackages = with pkgs; [
      beeper
      obsidian
      plex-htpc

      gimp
      inkscape

      vesktop

      fritzing
      godot_4
      cura-appimage
    ];
  };
}
