{ pkgs, ... }: {

  fonts = {

    packages = with pkgs; [
      nanum # For korean support
      (nerdfonts.override { fonts = [ "Iosevka" "FiraCode" ]; })
    ];

    fontconfig = {
      defaultFonts = {
        serif = [  "Liberation Serif" "Nanum Gothic" ];
        sansSerif = [ "Ubuntu" "Nanum Gothic" ];
        monospace = [ "Iosevka NFM" "Ubuntu Mono" ];
      };
    };

  };

}