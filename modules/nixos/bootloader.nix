{ inputs, lib, config, ... }: 

let 
  themePaths = {
    sleek-dark = "${inputs.sleek-grub}/Sleek theme-dark/sleek";
    catpuccin-macchiato = "${inputs.catpuccin-grub}/src/catppuccin-macchiato-grub-theme";
  };

  cfg = config.bootloader;
in {
  options.bootloader = with lib; {
    theme = mkOption {
      type = types.str;
      default = "catpuccin-macchiato";
      example = "catpuccin-macchiato";
      description = "Which theme to use on startup. Current options are: catpuccin, sleek-dark"; 
    };
  };

  config = {
    # Bootloader.
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.enable = false;
    
    boot.loader.grub = {
      enable = true;
      useOSProber = true;
      device = "nodev";
      efiSupport = true;
      theme = themePaths.${cfg.theme};
    };
  };
}