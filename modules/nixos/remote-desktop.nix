{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.remote;
in {
  options.my.remote = with lib; {
    server.enable = mkEnableOption "Sunshine";
    client.enable = mkEnableOption "Moonlight";
  };

  config = {
    services.sunshine = {
      enable = cfg.server.enable;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };

    environment.systemPackages = lib.mkIf cfg.client.enable [pkgs.moonlight-qt];
  };
}
