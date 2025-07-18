{ pkgs, unstable-pkgs, lib, config, ... }:

{
  imports = [
    ../desktop/gnome/home
    ./firefox
    ./git
    ./terminal
    ./audio.nix
    ./gaming.nix
    ./vscode.nix
    ./ssh.nix
  ];

  options.software = let
    enableOpt = lib.mkOption {
      type = lib.types.bool;
      description = "Activate this piece of software";
      default = false;
    };
  in {
    anydesk.enable = enableOpt;
    cura.enable = enableOpt;
    fragments.enable = enableOpt;
    

    discord.package = lib.mkOption {
      type = lib.types.package;
      description = "Which package to use for discord";
    };
  };

  config = let 
    cfg = config.software;

    optional-packages = list: lib.pipe list [
      (builtins.filter (x: cfg.${x}.enable))
      (builtins.map (x: pkgs.${x}))
    ];
  in {
    home.packages = (optional-packages [
      "anydesk"
      "cura"
      "fragments"
    ]) ++ [
      cfg.discord.package
    ] ++ (with pkgs; [
      inkscape
    ]) ++ (with unstable-pkgs; [
      beeper
      anytype
      gimp
      obsidian
    ]);

    
    home.keyboard = null;
    home.stateVersion = "23.11";
    programs.home-manager.enable = true;
  };
}
