{ pkgs, unstable-pkgs, hostname, flake-path, ... }: {

  home.packages = with pkgs; [
    alejandra # Nix formatter
    nixd # Nix LSP
    fritzing
    godot_4
  ];

  programs.vscode = {
    enable = true;
    package = unstable-pkgs.vscode;
    mutableExtensionsDir = false;

    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      # keep extensions minimal, additionnal extensions will be installed per project
      extensions = with unstable-pkgs.vscode-extensions; [
        # Nix editing
        jnoortheen.nix-ide
        arrterian.nix-env-selector

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
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "copilot-chat";
          publisher = "github";
          version = "0.37.4";
          sha256 = "sha256-as8aU8NIAe60qV2VihBa4ueOm23nBAos3AAyLA0Smhs=";
        }
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
  };

}
