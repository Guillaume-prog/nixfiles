{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.htpc.enable = lib.mkEnableOption "HTPC";

  config = lib.mkIf config.my.htpc.enable {
    home.packages = with pkgs; [
      chromium
      flex-launcher
      input-remapper
      plex-htpc
    ];

    # xdg.configFile."flex-launcher/config.ini".source = ./flexy-config.ini;

    xdg.desktopEntries.youtube = {
      name = "youtube";
      exec = "chromium --start-fullscreen --user-agent=\"Mozilla/5.0 (Linux; Tizen 2.3; SmartHub; SMART-TV; SmartTV; U; Maple2012) AppleWebKit/538.1+ (KHTML, like Gecko) TV Safari/538.1+\" youtube.com/tv";
      terminal = false;
      type = "Application";
      icon = ./icons/youtube.png;
    };
  };
}
