{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.software.desktop;
in {
  options.my.software.desktop = {
    enable = lib.mkEnableOption "Software used on desktop machines";
    media.enable = lib.mkEnableOption "Media management software";
    office.enable = lib.mkEnableOption "Office software";
  };

  config = {
    environment = lib.mkMerge [
      (lib.mkIf cfg.enable {
        systemPackages = with pkgs; [
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
      })
      (lib.mkIf cfg.media.enable {
        systemPackages = with pkgs; [
          nicotine-plus # Music downloader
          beets # Music library manager
          puddletag # Music tagger

          calibre # EPUB library manager

          mkvtoolnix # MKV manager
          subtitleedit # Subtitle editor
        ];
      })
      (lib.mkIf cfg.office.enable {
        systemPackages = with pkgs; [
          libreoffice
        ];
      })
    ];
  };
}
