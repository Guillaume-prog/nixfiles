{ pkgs, ... }: let
  samba-host="192.168.1.82";
  samba-user="lexi";
  samba-pass="fatcat44";
in {

  environment.systemPackages = [ pkgs.cifs-utils ];

  # Make sure to create a file called /etc/nixos/samba-secrets containing the following
  # username=<USERNAME>
  # domain=<DOMAIN> (optionnal)
  # password=<PASSWORD>

  fileSystems."/mnt/media" = {
    device = "//${samba-host}/media";
    fsType = "cifs";
    options = let
      automount-options="x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      read-write-options="uid=1000,gid=100,dir_mode=0755,file_mode=0755,rw";
    in [ 
      automount-options 
      read-write-options
      "username=${samba-user}" 
      "password=${samba-pass}"  
    ];
  };

}