{ pkgs, ... }: {

  programs.bash = {
    enable = true;
    shellAliases = {
      nx-rebuild = "pushd ~/nixfiles; git add .; sudo nixos-rebuild switch --flake .#beelink; popd";
    };
  };

}