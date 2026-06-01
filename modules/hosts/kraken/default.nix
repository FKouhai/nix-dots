{ inputs, ... }:
{
  flake.nixosConfigurations.kraken = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      inputs.self.nixosModules.kraken
      inputs.self.nixosModules.krakenHardware
      inputs.self.nixosModules.udev
      inputs.self.nixosModules.greeter
      inputs.self.nixosModules.themeData
      inputs.self.nixosModules.gpu
      inputs.self.nixosModules.ollama
      inputs.self.nixosModules.glance
      inputs.self.nixosModules.prometheus
"${inputs.self}/modules/features/host-options.nix"
      "${inputs.self}/modules/features/env-packages.nix"
      "${inputs.self}/modules/features/nix-config.nix"
      "${inputs.self}/modules/features/fish-config.nix"
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useUserPackages = true;
          useGlobalPkgs = true;
          sharedModules = [ inputs.agenix.homeManagerModules.age ];
          users.franky = import "${inputs.self}/modules/home.nix";
          extraSpecialArgs = {
            inherit inputs;
            system = "x86_64-linux";
          };
        };
      }
    ];
  };
}
