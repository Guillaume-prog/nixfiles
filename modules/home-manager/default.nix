{ pkgs, ... }:

{
  imports = [
    ./git.nix
    ./firefox
    ./bash.nix
  ];
}