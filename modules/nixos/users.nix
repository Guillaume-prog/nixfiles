{ lib, config, ... }:

let 
  cfg = config.user;

  user-options = with lib;{
    enable = mkOption {
      type = types.bool;
      description = "Activate this user for this machine";
      default = false;
    };

    home-config = mkOption {
      type = types.path;
      description = "Set home config";
      default = "";
    };
  };

  configure-user = name: 
  let 
    username = lib.toLower name;
  in lib.mkIf cfg.${username}.enable {
    users.users.${username} = {
      isNormalUser = true;
      description = name;
      extraGroups = [ "networkmanager" "wheel" ];
    };

    home-manager.users.${username} = import cfg.${username}.home-config;
  };
in 

{
  options.user = {
    guillaume = user-options;
    lilou = user-options;
  };

  config = lib.mkMerge [
    (configure-user "Guillaume") 
    (configure-user "Lilou")
  ];
}