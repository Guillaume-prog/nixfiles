{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];

  programs.nh = {
    enable = true;
    flake = "/home/guillaume/nixfiles";

    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
  };

}