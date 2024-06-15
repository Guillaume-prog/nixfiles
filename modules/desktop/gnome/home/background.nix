{ lib, config, ... }: 
with lib;
let
  cfg = config.desktop.gnome;
in
{
  options.desktop.gnome = {
    wallpaper.image = mkOption {
      type = lib.types.anything;
    };

    wallpaper.primary = mkOption {
      type = lib.types.str;
    };

    wallpaper.secondary = mkOption {
      type = lib.types.str;
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