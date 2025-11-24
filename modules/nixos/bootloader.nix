{ inputs, lib, config, ... }:

let 
  themePaths = {
    catpuccin-macchiato = "${inputs.catpuccin-grub}/src/catppuccin-macchiato-grub-theme";
  };

  cfg = config.my.bootloader;
in {
  options.my.bootloader = with lib; {
    enable = mkEnableOption "Custom bootloader";

    bootMode = mkOption {
      type = types.enum [ "legacy" "uefi" ];
      default = "uefi";
      description = "Boot mode: legacy MBR or modern UEFI";
    };

    device = mkOption {
      type = types.str;
      default = "nodev";
      description = "Device for legacy MBR installs. Ignored for UEFI.";
    };

    theme = mkOption {
      type = types.str;
      default = "catpuccin-macchiato";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.loader.systemd-boot.enable = false;

    # Legacy BIOS mode
    boot.loader.grub = {
      enable = true;
      useOSProber = true;
      theme = themePaths.${cfg.theme};

      device = if cfg.bootMode == "legacy" then cfg.device else "nodev";
      efiSupport = cfg.bootMode == "uefi";
      efiInstallAsRemovable = cfg.bootMode == "uefi";
    };
  };
}