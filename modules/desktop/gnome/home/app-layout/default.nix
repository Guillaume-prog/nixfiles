{ lib, ... }: 
let

  config = import ./settings.nix;

  # Function creates dconf compatible app picker entry based on name of app or folder and position.
  apl-entry = with lib.hm.gvariant; name: (position: 
    (mkDictionaryEntry[name (mkVariant [ 
      (mkDictionaryEntry["position" (mkVariant position)])
    ])])
  );

  # Takes a list of lists and converts them to app picker entries
  transformedList = with lib; map (innerList: 
    zipListsWith ( k: p: apl-entry k p ) innerList (genList (x: x) (length innerList))
  ) config.app-tray;

in
{

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/shell" = {
      favorite-apps = config.favorite-apps;
      app-picker-layout = transformedList;
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = config.app-folders;
    };

  } // config.folders;
}