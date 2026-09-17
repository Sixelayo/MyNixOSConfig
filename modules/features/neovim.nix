{ self, inputs, ... }:
{
  flake.nixosModules.neovim = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.neovim
    ];
  };

  perSystem = { pkgs, ... }: {
    packages.neovim = inputs.wrapper-modules.wrappers.neovim.wrap {
      inherit pkgs;

      settings.config_directory = ./neovim;
    };
  };
}
