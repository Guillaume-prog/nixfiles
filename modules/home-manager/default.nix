{
  pkgs,
  unstable-pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ../desktop/gnome/home
    ./firefox
    ./git
    ./terminal
    ./audio.nix
    ./gaming.nix
    ./vscode.nix
    ./ssh.nix
  ];

  home.keyboard = null;
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
