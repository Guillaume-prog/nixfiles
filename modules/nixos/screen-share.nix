{ unstable-pkgs, lib, config, ... }:
{
  options.screen-share = {
    enable = lib.mkOption {
      type = lib.types.bool;
      description = "Allow user to share their screen over Wifi";
      default = false;
    };
  };

  config = lib.mkIf config.screen-share.enable {
    environment.systemPackages = with unstable-pkgs; [
      gnome-network-displays
      gst_all_1.gst-vaapi
    ];

    networking.firewall.allowedTCPPorts = [ 7236 ];
    # networking.firewall.allowedUDPPorts = [ 7236 ];
  };

}