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
    # Controller & input support
    services.udev.packages = [pkgs.game-devices-udev-rules];

    # Power management (console behavior)
    services.logind.settings.Login = {
      HandlePowerKey = "poweroff";
      HandleSuspendKey = "ignore";
      IdleAction = "ignore";
    };

    # Prevent sleep / lock
    services.displayManager.gdm.autoSuspend = false;

    my.software.gaming.enable = true;

    # TODO: Remove hard coded username !!!
    home-manager.users."guillaume" = {
      my.htpc.enable = true;
    };
  };
}
