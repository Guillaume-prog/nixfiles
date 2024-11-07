{ ... }: {
  home.file.".ssh/config".text = ''
    Host homelab
      HostName 192.168.1.14
      User root

    Host vps
      HostName 82.165.119.207
      User root
  '';
}