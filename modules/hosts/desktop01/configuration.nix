{ self, inputs, ...} : {

  flake.nixosModules.desktop01Configuration = { pkgs, lib, ...} : {
    imports = [
      self.nixosModules.desktop01Hardware
      self.nixosModules.niri
      self.nixosModules.cliUtils
      self.nixosModules.neovim
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ##### Below is a paste of the default config with some deletion !
  };
}
