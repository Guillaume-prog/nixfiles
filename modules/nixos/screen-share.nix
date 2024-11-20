{ unstable-pkgs, ... }:
{

  environment.systemPackages = with unstable-pkgs; [
    gnome-network-displays
    gst_all_1.gst-vaapi
  ];

  networking.firewall.allowedTCPPorts = [ 7236 ];
  # networking.firewall.allowedUDPPorts = [ 7236 ];

}