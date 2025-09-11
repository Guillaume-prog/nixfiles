{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.git;
in {
  options.git = {
    username = mkOption {
      type = types.str;
      description = "Git user name";
    };

    email = mkOption {
      type = types.str;
      description = "Git user email";
    };
  };

  config = {
    programs.git = {
      enable = true;
      
      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        pull.rebase = false;
        user.name = cfg.username;
        user.email = cfg.email;
      };
    };
  };
}
