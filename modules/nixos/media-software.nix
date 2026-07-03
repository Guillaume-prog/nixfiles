{ pkgs, lib, config, ... }: {

  options.my.software.media = {
    enable = lib.mkEnableOption "A collection of media software (music, video, ebooks, etc.)";
  };

  config = lib.mkIf config.my.software.media.enable {

    environment.systemPackages = with pkgs; [ 
      nicotine-plus  # Music downloader
      beets # Music library manager
      puddletag # Music tagger

      calibre # EPUB library manager
      
      mkvtoolnix # MKV manager
      subtitleedit # Subtitle editor
    ];

  };
}