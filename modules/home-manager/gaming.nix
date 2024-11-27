{ pkgs, lib, config, ... }: {

  options.software.gaming = {
    enable = lib.mkOption {
      type = lib.types.bool;
      description = "Allow user to share their screen over Wifi";
      default = false;
    };
  };

  config = lib.mkIf config.software.gaming.enable {
    home.packages = with pkgs; [
      wine
      lutris
      prismlauncher
    ];
  } // {
    home.packages = [ pkgs.prismlauncher ];
  };

}