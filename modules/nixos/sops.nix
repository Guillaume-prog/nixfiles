{ self, inputs, pkgs, ... }: {

  environment.systemPackages = with pkgs; [ age sops ];

  home-manager.sharedModules = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    defaultSopsFile = self + "/secrets.yaml";
    age.keyFile = "/var/lib/sops/age/keys.txt";
  };

  sops.secrets."smb-credentials" = {
    owner = "root";
    mode = "0600";
  };

}