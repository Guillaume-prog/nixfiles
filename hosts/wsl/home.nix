{ pkgs, ... }:

{ 
  imports = [
    ../../modules/home-manager/terminal
    ../../modules/home-manager/git.nix
  ];

  home = {
    username = "groussin";
    homeDirectory = "/home/groussin";
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}