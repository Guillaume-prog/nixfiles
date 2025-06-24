{ unstable-pkgs, lib, config, ... }:
{
  options.screen-share = {
    enable = lib.mkOption {
      type = lib.types.bool;
      description = "Allow user to share their screen over Wifi";
      default = false;
    };
  };

  config = lib.mkIf config.screen-share.enable {
    # Virtual display with dummy driver
    # services.xserver = {
    #   enable = true;
    #   videoDrivers = [ "dummy" ];
    #   displayManager.startx.enable = true;

    #   serverLayout = ''
    #     Section "ServerLayout"
    #         Identifier     "X.org Configured"
    #         Screen      0  "Screen0" 0 0
    #         Screen      1  "Screen1" RightOf "Screen0"
    #     EndSection

    #     Section "Device"
    #         Identifier  "Card0"
    #         Driver      "dummy"
    #         VideoRam    256000
    #     EndSection

    #     Section "Monitor"
    #         Identifier  "Monitor0"
    #     EndSection

    #     Section "Monitor"
    #         Identifier  "Monitor1"
    #     EndSection

    #     Section "Screen"
    #         Identifier "Screen0"
    #         Device     "Card0"
    #         Monitor    "Monitor0"
    #         DefaultDepth 24
    #         SubSection "Display"
    #             Depth 24
    #             Modes "1920x1080"
    #         EndSubSection
    #     EndSection

    #     Section "Screen"
    #         Identifier "Screen1"
    #         Device     "Card0"
    #         Monitor    "Monitor1"
    #         DefaultDepth 24
    #         SubSection "Display"
    #             Depth 24
    #             Modes "1280x800"
    #         EndSubSection
    #     EndSection
    #   '';
    # };

    # services.x11vnc = {
    #   enable = true;
    #   display = ":1";
    #   allow = "192.168.0.0/24";
    #   passwordFile = "/etc/x11vnc.pass"; # Run once: echo "yourpassword" | x11vnc -storepasswd - /etc/x11vnc.pass
    # };
  };

}