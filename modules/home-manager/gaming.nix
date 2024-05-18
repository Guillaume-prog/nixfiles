{ pkgs, ... }: {

  home.packages = with pkgs; [
    wine
    lutris
    prismlauncher
  ];

}