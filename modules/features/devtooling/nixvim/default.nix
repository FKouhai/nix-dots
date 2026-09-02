{
  lib,
  config,
  inputs,
  pkgs,
  osConfig,
  ...
}:
{
  options = {
    nixvim.enable = lib.mkEnableOption "Enable nixvim module";
  };

  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
      enable = true;
      nixpkgs.config.allowUnfree = true;
      nixpkgs.overlays = [ inputs.kanoxo.overlays.default ];
      imports = [
        inputs.frostvim.nixvimModules.base
        inputs.frostvim.nixvimModules.blink
        inputs.frostvim.nixvimModules.clipboard-image
        inputs.frostvim.nixvimModules.dashboard
        inputs.frostvim.nixvimModules.git
        inputs.frostvim.nixvimModules.go
        inputs.frostvim.nixvimModules.images
        inputs.frostvim.nixvimModules.lint
        inputs.frostvim.nixvimModules.lsp
        inputs.frostvim.nixvimModules.lualine
        inputs.frostvim.nixvimModules.luasnip
        inputs.frostvim.nixvimModules.markdown-preview
        inputs.frostvim.nixvimModules.mini
        inputs.frostvim.nixvimModules.noice
        inputs.frostvim.nixvimModules.oil
        inputs.frostvim.nixvimModules.presence
        inputs.frostvim.nixvimModules.quicker
        inputs.frostvim.nixvimModules.snacks
        inputs.frostvim.nixvimModules.telekasten
        inputs.frostvim.nixvimModules.tree-sitter
        inputs.frostvim.nixvimModules.trouble
        inputs.frostvim.nixvimModules.web-devicons
        inputs.frostvim.nixvimModules.which-key
        inputs.frostvim.nixvimModules.kanoxo
      ];

      kanoxo = {
        enable = true;
        variant = "wave";
        transparent = true;
        terminalColors = false;
      };
      keymaps = [
        {
          mode = "n";
          key = "<leader>nv";
          action = ":vertical new <CR>";

        }
        {
          mode = "n";
          key = "<leader>nh";
          action = ":horizontal new <CR>";

        }
        {
          mode = "n";
          key = "<leader>pb";
          action = ":bprev <CR>";

        }
        {
          mode = "n";
          key = "<leader>pn";
          action = ":bnext <CR>";

        }
      ];

      plugins = {
        lsp.servers.nixd.settings =
          let
            flake = ''(builtins.getFlake "${inputs.self}")'';
          in
          {
            nixpkgs.expr = "import ${flake}.inputs.nixpkgs {}";
            nixos.expr = "${flake}.nixosConfigurations.${osConfig.networking.hostName}.options";
          };
      };
    };
  };
}
