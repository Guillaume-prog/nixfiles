{ lib, ... }: 
let
  apl-entry = with lib.hm.gvariant; name: (position: 
    (mkDictionaryEntry[name (mkVariant [ 
      (mkDictionaryEntry["position" (mkVariant position)])
    ])])
  );
in
{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "vencorddesktop.desktop"
        "codium.desktop"
        "net.lutris.Lutris.desktop"
        "org.prismlauncher.PrismLauncher.desktop"
        "org.gnome.Nautilus.desktop"
      ];

      app-picker-layout = [ [
        (apl-entry "Desktop" 0)
        (apl-entry "System" 1)
        (apl-entry "Utilities" 2)
        (apl-entry "beeper.desktop" 3)
        (apl-entry "steam.desktop" 4)
      ] ];
    };

    # Custom app folders

    "org/gnome/desktop/app-folders" = {
      folder-children = [ "Desktop" "Utilities" "System" ];
    };

    "org/gnome/desktop/app-folders/folders/Desktop" = {
      apps = [ "org.gnome.Calculator.desktop" "org.gnome.Calendar.desktop" "org.gnome.Snapshot.desktop" "org.gnome.clocks.desktop" "simple-scan.desktop" "org.gnome.Evince.desktop" "org.gnome.Loupe.desktop" "org.gnome.gedit.desktop" "vlc.desktop" ];
      name = "Desktop";
      translate = false;
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [ "org.gnome.FileRoller.desktop" "org.gnome.Connections.desktop" "org.gnome.baobab.desktop" "org.gnome.Extensions.desktop" "org.gnome.font-viewer.desktop" "org.gnome.Logs.desktop" "cups.desktop" "org.gnome.seahorse.Application.desktop" ];
      name = "Utilities";
      translate = false;
    };

    "org/gnome/desktop/app-folders/folders/System" = {
      apps = [ "org.gnome.Console.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.Settings.desktop" "gnome-system-monitor.desktop" "org.gnome.tweaks.desktop" ];
      name = "System";
      translate = false;
    };
  };
}