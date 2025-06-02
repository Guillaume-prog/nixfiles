{ lib, ... }: 
with lib.hm.gvariant; {
  
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      current = mkUint32 0;
      sources = [ (mkTuple [ "xkb" "fr" ]) ];
    };
  };

  imports = [
    ./app-layout
    ./background.nix
    ./extensions.nix
    ./shortcuts.nix
    ./trackpad.nix
  ];

}