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
      _module.args.inputs = inputs;
      enable = true;
      nixpkgs.config.allowUnfree = true;
      nixpkgs.overlays = [ inputs.kanoxo.overlays.default ];
      imports = [
        inputs.frostvim.nixvimModules.base
        inputs.frostvim.nixvimModules.blink
        inputs.frostvim.nixvimModules.clipboard-image
        inputs.frostvim.nixvimModules.dashboard
        inputs.frostvim.nixvimModules.dap
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

      plugins = {
        avante = {
          enable = true;
          settings = {
            provider = "opencode";
            acp_providrs = {
              opencode = {
                command = "opencode";
                args = [ "acp" ];
              };
            };
          };
        };

        lsp.servers.nixd.settings =
          let
            flake = ''(builtins.getFlake "${inputs.self}")'';
          in
          {
            nixpkgs.expr = "import ${flake}.inputs.nixpkgs {}";
            nixos.expr = "${flake}.nixosConfigurations.${osConfig.host.hostName}.options";
          };
      };
    };
  };
}
