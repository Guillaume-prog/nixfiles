{ ... }: {

  programs.bash = {
    enable = true;
    shellAliases = {
      nx-rebuild = "pushd ~/nixfiles; git add .; sudo nixos-rebuild switch --flake .#beelink; popd";
      nx-update = "pushd ~/nixfiles; sudo nix flake update; popd; nx-rebuild";
    };
  };

}