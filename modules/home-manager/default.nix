{...}: {
  imports = [
    ../desktop/gnome/home
    ./firefox
    ./git
    ./htpc
    ./terminal
    ./audio.nix
    ./vscode.nix
    ./ssh.nix
  ];

  home.keyboard = null;
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
