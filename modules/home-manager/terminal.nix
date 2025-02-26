{ inputs, pkgs, ... }: 
let
  wfetch = inputs.wfetch.packages.${pkgs.system}.default;
in {

    home.packages = [
        wfetch
        pkgs.tree
        pkgs.vim
    ];

    programs.alacritty = {
        enable = true;
    
        settings = {
            general.import = [
                "${inputs.alacritty-themes}/themes/catpuccin-machiatto.toml"
            ];

            font.normal = {
                family = "FiraCode Nerd Font Mono";
                style = "Regular";
            };

            window.padding = {
                x = 8;
                y = 8;
            };
        };
    };

    programs.direnv = {
        enable = true;
        enableBashIntegration = true;
        nix-direnv.enable = true;
    };

    programs.bash = {
        enable = true;
        bashrcExtra = ''eval "$(direnv hook bash)"'';
    };

    home.file.".config/direnv/direnv.toml".text = ''
        hide_env_diff = true
    '';

}