{ pkgs, ... }: {

  home.packages = (with pkgs.gnomeExtensions; [
    appindicator
    bluetooth-battery-meter
    blur-my-shell
    brightness-control-using-ddcutil
    user-themes
    vitals
  ]) ++ (with pkgs; [
    bibata-cursors
    ddcutil
  ]);

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      cursor-theme = "Bibata-Modern-Ice";
    };

    "org/gnome/shell" = {
      enabled-extensions = [ 
        "appindicatorsupport@rgcjonas.gmail.com" 
        "Bluetooth-Battery-Meter@maniacx.github.com" 
        "user-theme@gnome-shell-extensions.gcampax.github.com" 
        "Vitals@CoreCoding.com" 
        "blur-my-shell@aunetx"
        "display-brightness-ddcutil@themightydeity.github.com"
      ];
    };

    "org/gnome/shell/extensions/vitals" = {
      hot-sensors = [ "_processor_usage_" "_memory_usage_" "__network-rx_max__" ];
    };

    "org/gnome/shell/extensions/appindicator" = {
      tray-pos = "left";
    };

    "org/gnome/shell/extensions/Bluetooth-Battery-Meter" = {
      enable-battery-level-text = true;
    };

    "org/gnome/shell/extensions/display-brightness-ddcutil" = {
      button-location = 1;
      only-all-slider = true;
      show-display-name = false;
      ddcutil-binary-path = "${pkgs.ddcutil}/bin/ddcutil";
    };

  };

}