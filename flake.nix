{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    frostvim.url = "github:FKouhai/frostvim/main";
    agenix.url = "github:ryantm/agenix";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tokyonight = {
      url = "github:mrjones2014/tokyonight.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    wallpapers = {
      url = "github:FKouhai/Kanagawa-wallpapers";
    };
    zmk-cli = {
      url = "github:FKouhai/zmk-cli-flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      agenix,
      chaotic,
      frostvim,
      home-manager,
      nixpkgs,
      zen-browser,
      stylix,
      wallpapers,
      tokyonight,
      zmk-cli,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "franky";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      env_pkgs = {
        environment.systemPackages = [
          pkgs.ghostty
          frostvim.packages.${system}.default
          zen-browser.packages.x86_64-linux.default
          agenix.packages.x86_64-linux.default
          wallpapers.packages.x86_64-linux.default
          zmk-cli.packages.x86_64-linux.default
        ];
      };
      hm_user_cfg = {
        home-manager.users."${username}" = {
          imports = [
            ./home.nix
          ];
        };
      };
    in
    {
      nixosConfigurations."franktory" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        inherit pkgs;
        specialArgs = {
          inherit inputs;
        };
        modules = with pkgs; [
          ./hosts/franktory/etc/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          agenix.homeManagerModules.default
          env_pkgs
          hm_user_cfg
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              extraSpecialArgs = {
                vars = {
                  hostName = "franktory";
                  isDesktop = false;
                  class = "laptop";
                  wallpaper = "${wallpapers}/kanagawa-dragon/sciel.jpg";
                  mainMonitor = {
                    name = "eDP-1";
                    width = "1920";
                    height = "1080";
                    refresh = "60";
                  };
                  secondaryMonitor = {
                    name = "HDMI-A-2";
                    width = "1920";
                    height = "1080";
                    refresh = "60";
                  };
                };
                inherit inputs system;
              };
            };
          }
        ];
      };
      nixosConfigurations."kraken" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        inherit pkgs;
        specialArgs = {
          inherit inputs;
        };

        modules = with pkgs; [
          ./hosts/kraken/etc/nixos/configuration.nix
          chaotic.nixosModules.default
          home-manager.nixosModules.home-manager
          env_pkgs
          hm_user_cfg
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              sharedModules = [
                agenix.homeManagerModules.age
              ];
              extraSpecialArgs = {
                vars = {
                  hostName = "kraken";
                  isDesktop = true;
                  class = "desktop";
                  wallpaper = "${wallpapers.packages.x86_64-linux.default}/share/wallpapers/kanagawa-dragon/cthulu_2.png";
                  mainMonitor = {
                    name = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. GS27QA 24286B001135";
                    width = "2560";
                    height = "1440";
                    refresh = "180";
                  };
                  secondaryMonitor = {
                    name = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. GS27QA 24286B001081";
                    width = "2560";
                    height = "1440";
                    refresh = "144";
                  };
                };
                inherit inputs system;
              };
            };
          }
        ];
      };
    };
}
