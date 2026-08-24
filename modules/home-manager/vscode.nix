{
  pkgs,
  hostname,
  flake-path,
  ...
}: {
  home.packages = with pkgs; [
    alejandra # Nix formatter
    nixd # Nix LSP
  ];

  programs.vscodium = {
    enable = true;
    mutableExtensionsDir = false;

    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      # keep extensions minimal, additionnal extensions will be installed per project
      extensions = with pkgs.vscode-extensions; [
        # Nix editing
        jnoortheen.nix-ide
        arrterian.nix-env-selector
        kamadorueda.alejandra

        # Better errors
        usernamehw.errorlens

        # Theming
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons

        # Python
        ms-python.python

        # Rust
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        fill-labs.dependi

        editorconfig.editorconfig
        esbenp.prettier-vscode
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
        "nixEnvSelector.useFlakes" = true;
      };
    };
  };
}
