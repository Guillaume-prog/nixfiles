{ pkgs, ... }: {

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = [ 
      pkgs.gutenprint # — Drivers for many different printers from many different vendors.
      pkgs.gutenprintBin # — Additional, binary-only drivers for some printers.
      pkgs.cnijfilter2 # — Drivers for some Canon Pixma devices (Proprietary driver)
    ];
  };

}