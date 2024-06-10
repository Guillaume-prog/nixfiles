{ lib, config, ... }:
with lib;
let
  cfg = config.keyboard;
in {
  options = {
    keyboard.layout = mkOption {
      type = types.anything;
      description = "Which layout to use for typing";
    };
  };

  config = {

    # Configure keymap in X11
    services.xserver.xkb = cfg.layout;

    # Configure console keymap
    console.useXkbConfig = true;

  };

}