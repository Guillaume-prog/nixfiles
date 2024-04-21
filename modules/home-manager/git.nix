{ pkgs, ... }: {

  programs.git = {
    enable = true;

    userName = "Guillaume-prog";
    userEmail = "76855158+Guillaume-prog@users.noreply.github.com";
    
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

}