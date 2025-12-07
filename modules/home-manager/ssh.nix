{ ... }: {
  home.file.".ssh/config".text = ''
    Host hass
      HostName 192.168.1.201
      User root

    Host nas
      HostName 192.168.1.200
      User truenas_admin
      Port 9222

    Host potato
      HostName 192.168.1.201
      User lexi

    Host vps
      HostName 82.165.119.207
      User root
  '';
}