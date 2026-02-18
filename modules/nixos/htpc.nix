{ unstable-pkgs, lib, config, ... }: 
let 
  cfg = config.my.htpc;
in {

  options.my.htpc = with lib; {
    enable = mkEnableOption "HTPC";
    user = mkOption {
      type = types.str;
      default = "";
      description = "User to autologin";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with unstable-pkgs; [
      steam
      gamescope
      mangohud

      plex-htpc
      chromium

      (writeShellScriptBin "plex-htpc-steam" ''
        #!/usr/bin/env bash
        export QT_QPA_PLATFORM=wayland
        export SDL_VIDEODRIVER=wayland
        export XDG_SESSION_TYPE=wayland

        exec ${pkgs.plex-htpc}/bin/plex-htpc
      '')

      (writeShellScriptBin "youtube-tv-steam" ''
        #!/usr/bin/env bash

        export XDG_SESSION_TYPE=wayland
        export QT_QPA_PLATFORM=wayland
        export SDL_VIDEODRIVER=wayland
        export MOZ_ENABLE_WAYLAND=1

        exec ${pkgs.chromium}/bin/chromium \
          --app=https://www.youtube.com/tv \
          --start-fullscreen \
          --no-first-run \
          --disable-infobars \
          --disable-session-crashed-bubble \
          --disable-features=TranslateUI \
          --ozone-platform=wayland \
          --enable-features=UseOzonePlatform
      '')
    ];

    # Autologin
    services.xserver.displayManager.gdm = {
      enable = true;
      autoLogin.enable = true;
      autoLogin.user = cfg.user;
    };

    # Steam + Gamescope (SteamOS-style session)
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    # Force Steam session (bypasses GNOME entirely)
    services.xserver.displayManager.defaultSession = "steam";
    #services.xserver.desktopManager.gnome.enable = lib.mkForce false;

    # Controller & input support
    services.udev.packages = [ unstable-pkgs.game-devices-udev-rules ];

    # Power management (console behavior)
    services.logind.settings.Login = {
      HandlePowerKey = "poweroff";
      HandleSuspendKey = "ignore";
      IdleAction = "ignore";
    };

    # Prevent sleep / lock
    services.xserver.displayManager.gdm.autoSuspend = false;

    # Useful defaults for HTPCs
    hardware.opengl.enable = true;

    # Optional: ensure graphical boot
    systemd.defaultUnit = "graphical.target";

  };
}