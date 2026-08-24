{ lib, config, ... }: 
let
  cfg = config.my.desktop.gnome;
in
{
  options.my.desktop.gnome.wallpaper = with lib; {
    image = mkOption {
      type = types.anything;
    };

    primary = mkOption {
      type = types.str;
    };

    secondary = mkOption {
      type = types.str;
    };

  };

  config = 
  let
    path = "${config.home.homeDirectory}/.background-image";
  in 
  {

    home.file.".background-image".source = cfg.wallpaper.image;
    
    dconf.settings = {
      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = path;
        picture-uri-dark = path;
        primary-color = cfg.wallpaper.primary;
        secondary-color = cfg.wallpaper.secondary;
      };

      "org/gnome/desktop/screensaver" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = path;
        primary-color = cfg.wallpaper.primary;
        secondary-color = cfg.wallpaper.secondary;
      };
    };

  };
}