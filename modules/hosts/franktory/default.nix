{ inputs, ... }:
{
  flake.nixosConfigurations.franktory = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      inputs.self.nixosModules.franktory
      inputs.self.nixosModules.franktoryHardware
      inputs.self.nixosModules.udev
      inputs.self.nixosModules.greeter
      inputs.self.nixosModules.themeData
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
