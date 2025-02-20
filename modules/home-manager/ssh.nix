{ ... }: {
  home.file.".ssh/config".text = ''
    Host hass
      HostName 192.168.1.14
      User root

    Host homelab
      HostName 192.168.1.82
      User lexi

    Host nas
      HostName 192.168.1.48
      User yriel
      Port 9222

    Host vps
      HostName 82.165.119.207
      User root
  '';
}