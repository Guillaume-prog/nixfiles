{ pkgs, unstable-pkgs, inputs, ... }: {
  
  # Hotfix until 24.05 comes out
  imports = ["${inputs.nixpkgs-unstable}/nixos/modules/programs/nh.nix"];

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];

  programs.nh = {
    enable = true;
    package = unstable-pkgs.nh;
    flake = "/home/guillaume/nixfiles";

    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

}