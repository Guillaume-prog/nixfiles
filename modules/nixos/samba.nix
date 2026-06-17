{ pkgs, lib, config, ... }: let
  samba-host="192.168.1.200";
in {

  options.my.samba = {
    enable = lib.mkEnableOption "Mount the NAS share";
  };

  config = lib.mkIf config.my.samba.enable {
    
    environment.systemPackages = [ pkgs.cifs-utils ];

    # Mount the NAS share
    environment.etc."smb-credentials".source = config.sops.secrets."smb-credentials".path;

    fileSystems."/mnt/nas" = {
      device = "//${samba-host}/media";
      fsType = "cifs";

      # Credentials
      options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
        permissions_opts = "uid=1000,gid=100";
      in ["${automount_opts},${permissions_opts},credentials=/etc/smb-credentials"];
    };

  };

}