{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    libimobiledevice
    ifuse
  ];

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  programs.bash.shellAliases = let 
    loc = "/tmp/iphone";
  in {
    iphone = "mkdir -p ${loc}; ifuse ${loc}; nautilus ${loc}";
  };

}