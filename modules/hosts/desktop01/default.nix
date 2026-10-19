{ self, inputs, ...} : {
  flake.nixosConfigurations.desktop01 = inputs.nixpkgs.lib.nixosSystem {
    modules = [ 
      self.nixosModules.desktop01Configuration
    ];
  };
}
