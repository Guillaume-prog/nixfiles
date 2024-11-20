{ pkgs, unstable-pkgs, ... }:

{
  imports = [
    ../desktop/gnome/home
    ./terminal.nix
    ./audio.nix
    ./git.nix
    ./firefox
    ./gaming.nix
    ./vscode.nix
    ./ssh.nix
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = (with pkgs; [
    anydesk
    cura
    fragments
    vesktop
    beeper
  ]) ++ (with unstable-pkgs; [
    anytype
    # beeper
  ]);

  
  
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
