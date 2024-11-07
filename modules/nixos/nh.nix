{ pkgs, flake-path, ... }: {

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];

  programs.nh = {
    enable = true;
    flake = flake-path;

    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
  };

}