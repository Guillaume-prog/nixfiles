{
  pkgs,
  lib,
  config,
  ...
}: let
  assets-path = "/nixfiles/modules/home-manager/htpc/flex-launcher";

  raw-conf = builtins.readFile ./flex-launcher/config.ini;
  parsed-conf = builtins.replaceStrings ["icon:" "asset:"] ["${assets-path}/icons/" "${assets-path}/"] raw-conf;
in {
  options.my.htpc.enable = lib.mkEnableOption "HTPC";

  config = lib.mkIf config.my.htpc.enable {
    xdg.configFile."flex-launcher/config.ini".text = parsed-conf;
    xdg.configFile."input-remapper-2/presets/DualSense Wireless Controller/Youtube controller.json".source = ./ytcontroller.json;

    xdg.autostart = {
      enable = true;
      entries = ["${pkgs.flex-launcher}/share/applications/flex-launcher.desktop"];
    };

    dconf.settings = {
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/youtube-stop/"];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/youtube-stop" = {
        name = "Youtube Stop";
        binding = "<Control><Alt>q";
        command = "bash /nixfiles/modules/home-manager/htpc/flex-launcher/scripts/youtube-stop.bash";
      };
    };

    xdg.desktopEntries.youtube = {
      name = "youtube";
      exec = "chromium --start-fullscreen --user-agent=\"Mozilla/5.0 (Linux; Tizen 2.3; SmartHub; SMART-TV; SmartTV; U; Maple2012) AppleWebKit/538.1+ (KHTML, like Gecko) TV Safari/538.1+\" youtube.com/tv";
      terminal = false;
      type = "Application";
      icon = ./flex-launcher/icons/youtube.png;
    };
  };
}
