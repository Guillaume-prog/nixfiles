{ lib, config, ... }: 
let
  cfg = config.desktop.gnome;
in
{
  options.desktop.gnome = with lib; {
    wallpaper.image = mkOption {
      type = types.anything;
    };

    wallpaper.primary = mkOption {
      type = types.str;
    };

    wallpaper.secondary = mkOption {
      type = types.str;
    };

  };

  config = 
  let
    path = "/home/guillaume/.background-image";
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