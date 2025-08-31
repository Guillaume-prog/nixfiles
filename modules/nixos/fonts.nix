{ pkgs, ... }: {

  fonts = {

    packages = (with pkgs; [
      nanum # For korean support
    ]) ++ (with pkgs.nerd-fonts; [
      iosevka
      fira-code
    ]);

    fontconfig = {
      defaultFonts = {
        serif = [  "Liberation Serif" "Nanum Gothic" ];
        sansSerif = [ "Ubuntu" "Nanum Gothic" ];
        monospace = [ "Iosevka NFM" "Ubuntu Mono" ];
      };
    };

  };

}