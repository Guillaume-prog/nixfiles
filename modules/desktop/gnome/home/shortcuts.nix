{ ... }: {
  dconf.settings = {
    "org/gnome/shell/keybinding" = {
      show-screenshot-ui = [ "<Shift><Control>s" ];
      screenshot = [ "<Control><Super>s" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Terminal";
      binding = "<Control><Alt>t";
      command = "alacritty";
    };
  };
}