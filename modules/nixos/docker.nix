{
  lib,
  config,
  ...
}: {
  options.my.software.docker.enable = lib.mkEnableOption "docker on device";

  config = lib.mkIf config.my.software.docker.enable {
    virtualisation.docker.enable = true;
    users.extraGroups.docker.members = ["guillaume"];
  };
}
