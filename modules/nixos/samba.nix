{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.samba;
  samba-host = "192.168.1.200";

  samba-fs = enable: path:
    lib.mkIf enable {
      device = "//${samba-host}/${path}";
      fsType = "cifs";

      # Credentials
      options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
        permissions_opts = "uid=1000,gid=100";
      in ["${automount_opts},${permissions_opts},credentials=/etc/smb-credentials"];
    };
in {
  options.my.samba = {
    nas.enable = lib.mkEnableOption "Mount the NAS share";
    pictures.enable = lib.mkEnableOption "Mount the pictures share";
  };

  config = lib.mkIf (cfg.nas.enable || cfg.pictures.enable) {
    environment.systemPackages = [pkgs.cifs-utils];

    # Mount the NAS share
    environment.etc."smb-credentials".source = config.sops.secrets."smb-credentials".path;

    fileSystems."/mnt/nas" = samba-fs cfg.nas.enable "media";
    fileSystems."/mnt/pictures" = samba-fs cfg.pictures.enable "pictures";
  };
}
