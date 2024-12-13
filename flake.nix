{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
  };

  outputs = { home-manager, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    username = "franky";
  in
  {
    homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { inherit system; 
          overlays = [
            inputs.hyprpanel.overlay
          ];

        };

      # pass inputs as specialArgs
      extraSpecialArgs = { 
          inherit inputs;
          inherit system;

        };

      # import your home.nix
      modules = [ ./home.nix ];
    };
  };
}
