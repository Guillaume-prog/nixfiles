{ ... }: 
let
  username = "guillaume";
  home = "/home/${username}";
in {

  services.syncthing = {
    enable = true;
    user = username;
    dataDir = "${home}/Documents";
    configDir = "${home}/Documents/.config/syncthing";
    overrideDevices = true;     # overrides any devices added or deleted through the WebUI
    overrideFolders = true;     # overrides any folders added or deleted through the WebUI

    settings = {
      options.urAccepted = -1; # Refuse anonymous usage data

      devices = {
        "Phone" = { id = "M25ZJ2M-M7WCPVM-5EVFGSQ-VBGDCH3-HODXVMM-YZRTWST-JZE3SFT-IE2NLAO"; };
        "Tablet" = { id = "R7ZG6WQ-FWO37NN-HTVBBGY-TIZWEFR-7LVS2AI-UG6RQZY-OF7AWEN-WM25NAZ"; };
      };

      folders = {
        "Sync" = {         # Name of folder in Syncthing, also the folder ID
          path = "${home}/Sync";    # Which folder to add to Syncthing
          devices = [ "Phone" "Tablet" ];      # Which devices to share the folder with
          ignorePerms = false;
        };
      };
    };

  };

  # Syncthing ports: 8384 for remote access to GUI
  # 22000 TCP and/or UDP for sync traffic
  # 21027/UDP for discovery
  # source: https://docs.syncthing.net/users/firewall.html
  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

}