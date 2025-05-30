{ inputs, pkgs, ... }: 
let
  wfetch = inputs.wfetch.packages.${pkgs.system}.default;
in {

    home.packages = [
        wfetch
    ] ++ (with pkgs; [
        fastfetch
        tree
        vim
    ]);

    programs.alacritty = {
        enable = true;
    
        settings = {
            general.import = [
                "${inputs.alacritty-themes}/themes/catpuccin-machiatto.toml"
            ];

            font.normal = {
                family = "Iosevka Nerd Font";
                style = "Regular";
            };

            window.padding = {
                x = 8;
                y = 8;
            };
        };
    };

    programs.oh-my-posh = {
        enable = true;
        enableBashIntegration = true;
        settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./posh.omp.json));
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