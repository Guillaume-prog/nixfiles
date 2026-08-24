{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.software.gaming.enable = lib.mkEnableOption "Gaming software";

  config = lib.mkIf config.my.software.gaming.enable {
    environment.systemPackages = with pkgs; [
      prismlauncher
      owmods-cli
    ];

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
  };
}
