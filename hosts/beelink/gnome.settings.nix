{

favorite-apps = ["firefox.desktop" "plex-htpc.desktop" "steam.desktop"];
app-folders = ["Desktop" "Utilities" "System"];
app-tray = [["Desktop" "System" "Utilities" "netbird.desktop" "PEAK.desktop" "org.pulseaudio.pavucontrol.desktop" "codium.desktop" "org.prismlauncher.PrismLauncher.desktop"]];

folders = {

	"org/gnome/desktop/app-folders/folders/Desktop" = {
		apps=["org.gnome.Calculator.desktop" "org.gnome.Calendar.desktop" "org.gnome.Snapshot.desktop" "org.gnome.clocks.desktop" "simple-scan.desktop" "org.gnome.Evince.desktop" "org.gnome.Loupe.desktop" "org.gnome.gedit.desktop" "vlc.desktop" "org.gnome.Nautilus.desktop" "org.gnome.SimpleScan.desktop" "org.gnome.Decibels.desktop" "org.gnome.Papers.desktop" "org.gnome.Showtime.desktop"];
		name="Desktop";
		translate=false;
	};
	
	"org/gnome/desktop/app-folders/folders/Pardus" = {
		categories=["X-Pardus-Apps"];
		name="X-Pardus-Apps.directory";
		translate=true;
	};
	
	"org/gnome/desktop/app-folders/folders/System" = {
		apps=["Alacritty.desktop" "org.gnome.DiskUtility.desktop" "com.mattjakeman.ExtensionManager.desktop" "pavucontrol.desktop" "org.gnome.Settings.desktop" "org.gnome.SystemMonitor.desktop" "org.gnome.tweaks.desktop" "vim.desktop"];
		name="System";
		translate=false;
	};
	
	"org/gnome/desktop/app-folders/folders/Utilities" = {
		apps=["AnyDesk.desktop" "org.gnome.Connections.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.baobab.desktop" "org.gnome.Extensions.desktop" "org.gnome.FileRoller.desktop" "org.gnome.font-viewer.desktop" "de.haeckerfelix.Fragments.desktop" "org.gnome.Logs.desktop" "cups.desktop" "org.gnome.seahorse.Application.desktop"];
		name="Utilities";
		translate=false;
	};
	
	"org/gnome/desktop/app-folders/folders/YaST" = {
		categories=["X-SuSE-YaST"];
		name="suse-yast.directory";
		translate=true;
	};
	
};

}
