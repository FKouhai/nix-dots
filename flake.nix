{
  nixConfig = {

    extra-substituters = [
      "https://nix-community.cachix.org/"
      "https://attic.xuyh0120.win/lantian"
      "https://cache.nixos.org/"
    ];

    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    frostvim.url = "github:FKouhai/frostvim/main";
    helium.url = "github:FKouhai/helium2nix";
    agenix.url = "github:ryantm/agenix";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      noctalia,
      frostvim,
      home-manager,
      nixvim,
      nixpkgs,
      zen-browser,
      stylix,
      wallpapers,
      opencode,
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
        overlays = [
          nix-cachyos-kernel.overlays.pinned
        ];
      };

      # Create environment packages for different shells
      mkEnvPkgs = shell: {
        environment.systemPackages = [
          pkgs.ghostty
          zen-browser.packages.x86_64-linux.default
          agenix.packages.x86_64-linux.default
          opencode.packages.x86_64-linux.default
          wallpapers.packages.x86_64-linux.default
          zmk-cli.packages.x86_64-linux.default
          inputs.helium.defaultPackage.x86_64-linux
        ]
        ++ (
          if shell == "caelestia" then
            [
              caelestia-shell.packages.x86_64-linux.default
            ]
          else if shell == "noctalia" then
            [
              noctalia.packages.x86_64-linux.default
            ]
          else
            [ ]
        );
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
          (mkEnvPkgs "noctalia")
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
                  shell = "noctalia";
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
          (mkEnvPkgs "noctalia")
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
                  shell = "noctalia";
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
