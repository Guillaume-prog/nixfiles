{ pkgs, unstable-pkgs, lib, config, ... }: {

  options.software.gaming = {
    enable = lib.mkOption {
      type = lib.types.bool;
      description = "Install gaming software";
      default = false;
    };
  };

  config = lib.mkIf config.software.gaming.enable {
    home.packages = (with pkgs; [
      wine
      lutris
      prismlauncher
    ]) ++ (with unstable-pkgs; [
      owmods-cli
    ]);
  } // {
    home.packages = [ pkgs.prismlauncher ];
  };

}