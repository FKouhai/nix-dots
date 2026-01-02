{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    frostvim.url = "github:FKouhai/frostvim/main";
    agenix.url = "github:ryantm/agenix";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    caelestia-shell = {
      url = "github:anarion80/caelestia-shell/topbar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    opencode = {
      url = "github:sst/opencode";
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
    zed-extensions = {
      url = "github:DuskSystems/nix-zed-extensions";
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
      nix-cachyos-kernel,
      caelestia-shell,
      frostvim,
      home-manager,
      nixvim,
      nixpkgs,
      zen-browser,
      stylix,
      wallpapers,
      opencode,
      tokyonight,
      zed-extensions,
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
        overlays = [
          nix-cachyos-kernel.overlay
          zed-extensions.overlays.default
        ];
      };
      env_pkgs = {
        environment.systemPackages = [
          pkgs.ghostty

          zen-browser.packages.x86_64-linux.default
          agenix.packages.x86_64-linux.default
          caelestia-shell.packages.x86_64-linux.default
          opencode.packages.x86_64-linux.default
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
                  hostName = "franktory";
                  isDesktop = false;
                  class = "laptop";
                  wallpaper = "${wallpapers}/kanagawa-dragon/3895e.jpg";
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
                  wallpaper = "${wallpapers.packages.x86_64-linux.default}/share/wallpapers/kanagawa-dragon/3895e.jpg";
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
