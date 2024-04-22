{ pkgs, ... }: {

  # TODO: move nil installation from home.nix to here

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    enableUpdateCheck = true;
    enableExtensionUpdateCheck = true;
    # mutableExtensionsDir = true;

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
