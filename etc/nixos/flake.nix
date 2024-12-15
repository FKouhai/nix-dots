{
  description = "My system configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
  };
  ghostty = {
    url = "git+ssh://git@github.com/ghostty-org/ghostty";
    inputs.nixpkgs-stable.follows = "nixpkgs";
    inputs.nixpkgs-unstable.follows = "nixpkgs";
  };
  };

  outputs = { self, nixpkgs,ghostty, sddm-sugar-candy-nix, ... }@ inputs: {
    nixosConfigurations.franktory = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
      ./configuration.nix
      sddm-sugar-candy-nix.nixosModules.default
      {environment.systemPackages = [ghostty.packages.x86_64-linux.default];}
      {
      nixpkgs = {
      overlays = [
      sddm-sugar-candy-nix.overlays.default
      ]; 
      };
      }
      ];
    };
  };
}
