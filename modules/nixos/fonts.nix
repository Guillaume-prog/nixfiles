{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    nanum # For korean support
  ];

  # TODO: specify which font i want for korean

}