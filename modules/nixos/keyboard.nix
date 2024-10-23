{ lib, config, ... }:
with lib;
let
  cfg = strings.splitString "-" config.keyboard.layout;
  cfg_layout = elemAt cfg 0;
  cfg_variant = if (1 < builtins.length cfg) then (elemAt cfg 1) else "";
in {
  options.keyboard = {
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