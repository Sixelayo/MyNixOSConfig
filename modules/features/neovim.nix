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

      specs = with pkgs.vimPlugins; {
        tokyonight = tokyonight-nvim;

        bufferline = bufferline-nvim;
        lualine = lualine-nvim;
        telescope = telescope-nvim;
        web-devicons = nvim-web-devicons;

        mini-surround = mini-surround;
        mini-pairs = mini-pairs;

        nvim-cmp = nvim-cmp;
        cmp-nvim-lsp = cmp-nvim-lsp;
        cmp-path = cmp-path;
        cmp-buffer = cmp-buffer;

        nvim-lspconfig = nvim-lspconfig;

	nvim-treesitter = nvim-treesitter;
      };
    };
  };
}
