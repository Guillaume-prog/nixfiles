{ pkgs, unstable-pkgs, ... }: {

  home.packages = with pkgs; [
    nil # Nix Language server
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
    ];

    userSettings = {
      # Theming
      "workbench.iconTheme" = "catppuccin-macchiato";
      "workbench.colorTheme" = "Catppuccin Macchiato";

      # Nix LSP
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
    };
  };

}
