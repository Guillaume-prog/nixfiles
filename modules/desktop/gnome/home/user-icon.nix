{
  lib,
  config,
  ...
}: {
  options.my.desktop.gnome = with lib; {
    user-icon = mkOption {
      type = types.anything;
    };
  };

  config = {
    home.file.".face".source = config.my.desktop.gnome.user-icon;

    # system.activationScripts.script.text = let
    #   username = "";
    #   home = "";
    # in ''
    #   cp ${home}/.face /var/lib/AccountsService/icons/${username}
    # '';
  };
}
