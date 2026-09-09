{ self, inputs, ...} : {
  flake.nixosConfigurations.laptopCY = inputs.nixpkgs.lib.nixosSystem {
    modules = [ 
      self.nixosModules.laptopCYConfiguration
    ];
  };
}
 
