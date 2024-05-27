{ unstable-pkgs, ... }: {
  
  environment.sessionVariables = {
    FLAKE = "/home/guillaume/nixfiles";
  };

  environment.systemPackages = with unstable-pkgs; [
    nh  
  ];

  # programs.nh = {
  #   enable = true;
  #   clean.enable = true;
  #   clean.extraArgs = "--keep-since 4d --keep 3";
  #   flake = "/home/guillaume/nixfiles";
  # };

}