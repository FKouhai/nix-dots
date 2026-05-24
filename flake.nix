{
  nixConfig = {

    extra-substituters = [
      "https://nix-community.cachix.org/"
      "https://attic.xuyh0120.win/lantian"
      "https://cache.nixos.org/"
      "https://noctalia.cachix.org"
    ];

    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    nixvim.url = "github:nix-community/nixvim";
    frostvim.url = "github:FKouhai/frostvim";
    kanoxo = {
      url = "github:FKouhai/kanoxo-colorscheme";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium.url = "github:FKouhai/helium2nix";
    agenix.url = "github:ryantm/agenix";
    trigo.url = "github:FKouhai/trigo";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    opencode = {
      url = "github:anomalyco/opencode/refs/tags/v1.15.3";
    };
    tokyonight.url = "github:mrjones2014/tokyonight.nix";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    wallpapers = {
      url = "github:FKouhai/Kanagawa-wallpapers";
    };
  };

  outputs =
    inputs@{ flake-parts, import-tree, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        (import-tree ./modules/hosts)
        (import-tree ./modules/services)
        (import-tree ./modules/flake-parts)
      ];
      systems = [ "x86_64-linux" ];
    };
}
