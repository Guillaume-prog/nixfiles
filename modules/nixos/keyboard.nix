{ lib, config, ... }:
let
  cfg = lib.strings.splitString "-" config.keyboard.layout;
  cfg_layout = lib.elemAt cfg 0;
  cfg_variant = if (1 < builtins.length cfg) then (lib.elemAt cfg 1) else "";
in {
  options.keyboard = with lib; {
    layout = mkOption {
      type = types.str;
      description = "Which layout to use for typing";
    };
  };

  config = {

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = cfg_layout;
      variant = cfg_variant;
    };

    # Configure console keymap
    console.useXkbConfig = true;

  };

}