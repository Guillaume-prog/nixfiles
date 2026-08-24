{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.software.office.enable = lib.mkEnableOption "Office software";

  config = lib.mkIf config.my.software.office.enable {
    environment.systemPackages = with pkgs; [
      libreoffice
    ];
  };
}
