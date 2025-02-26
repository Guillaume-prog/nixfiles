{ ... }: {
  home.file.".ssh/config".text = ''
    Host hass
      HostName 192.168.1.201
      User root

    Host nas
      HostName 192.168.1.200
      User yriel
      Port 9222

    Host vps
      HostName 82.165.119.207
      User root
  '';
}