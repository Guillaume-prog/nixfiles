{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    nmap
    ncdu
    mlocate
    usbutils
    pciutils
  ];

  services.locate = {
    enable = true;
    package = pkgs.mlocate;
  };

}