{ pkgs, ... }: {

  home.packages = with pkgs; [
    steam
    wine

    lutris
    prismlauncher
  ];

}