{ pkgs, unstable-pkgs, hostname, flake-path, ... }: {

  home.packages = with pkgs; [
    alejandra # Nix formatter
    nixd # Nix LSP
    fritzing
    godot_4
  ];

  programs.vscode = {
    enable = true;
    package = unstable-pkgs.vscodium;

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;

    # keep extensions minimal, additionnal extensions will be installed per project
    extensions = with pkgs.vscode-extensions; [
      # Nix editing
      jnoortheen.nix-ide

      # Better errors
      usernamehw.errorlens

      # Theming
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons

      # Rust
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
      fill-labs.dependi
    ];

    userSettings = {
      # Git
      "git.confirmSync" = false;

      # Theming
      "workbench.iconTheme" = "catppuccin-macchiato";
      "workbench.colorTheme" = "Catppuccin Macchiato";

      "editor.fontFamily" = ["Iosevka Nerd Font" "Droid Sans Mono" "monospace"];

      # Nix config
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";

      "nixpkgs" = {
        "expr" = "import (builtins.getFlake ${flake-path}).inputs.nixpkgs {}";
      };

      "formatting" = {
        "command" = [ "alejandra" ];
      };

      "options" = {
        "expr" = "(builtins.getFlake ${flake-path}).nixosConfigurations.${hostname}.options";
      };
    };
  };

}
