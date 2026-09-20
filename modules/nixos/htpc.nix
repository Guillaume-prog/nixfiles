{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.htpc;
in {
  options.my.htpc = with lib; {
    enable = mkEnableOption "HTPC";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      chromium
      heroic
      flex-launcher
      plex-htpc
    ];

    # Controller & input support
    services.udev.packages = [pkgs.game-devices-udev-rules];

    services.input-remapper.enable = true;

    services.gnome.gnome-keyring.enable = lib.mkForce false;

    # Power management (console behavior)
    services.logind.settings.Login = {
      HandlePowerKey = "poweroff";
      HandleSuspendKey = "ignore";
      IdleAction = "ignore";
    };

    programs.chromium = {
      enable = true;
      extensions = [
        "ddkjiahejlhfcafbddmgiahcphecmpfh" # ublock origin lite
        "mnjggcdmjocbbbhaepdhchncahnbgone" # sponsorblock
      ];
      extraOpts = {
        "RestoreOnStartup" = 5;
      };
    };

    # Prevent sleep / lock
    services.displayManager.gdm.autoSuspend = false;

    my.software.gaming.enable = true;

    jovian.decky-loader = {
      enable = true;
      # stateDir = "${config.xdg.configHome}/decky-loader";
    };

    # environment.interactiveShellInit = ''
    #   alias youtube="chromium --start-fullscreen --user-agent=\"Mozilla/5.0 (Linux; Tizen 2.3; SmartHub; SMART-TV; SmartTV; U; Maple2012) AppleWebKit/538.1+ (KHTML, like Gecko) TV Safari/538.1+\" youtube.com/tv";
    # '';

    # TODO: Remove hard coded username !!!
    home-manager.users."guillaume" = {
      my.htpc.enable = true;
    };
  };
}
