{ pkgs, ... }: {

  home.packages = (with pkgs.gnomeExtensions; [
    appindicator
    blur-my-shell
    gsconnect
    user-themes
    vitals
  ]) ++ [
    pkgs.bibata-cursors
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      cursor-theme = "Bibata-Modern-Ice";
    };

    "org/gnome/shell" = {
      enabled-extensions = [ "appindicatorsupport@rgcjonas.gmail.com" "gsconnect@andyholmes.github.io" "user-theme@gnome-shell-extensions.gcampax.github.com" "Vitals@CoreCoding.com" "blur-my-shell@aunetx" ];
    };

    "org/gnome/shell/extensions/vitals" = {
      hot-sensors = [ "_processor_usage_" "_memory_usage_" "__network-rx_max__" ];
    };

  };

}