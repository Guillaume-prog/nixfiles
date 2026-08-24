{...}: {
  home.file.".ssh/config".text = ''
    Host nas
      HostName 192.168.1.200
      User truenas_admin
      Port 9222

    Host optiplex
      HostName 192.168.1.201
      User lexi

    Host hass
      HostName 192.168.1.202
      User root

    Host vps
      HostName 82.165.119.207
      User root
  '';
}
