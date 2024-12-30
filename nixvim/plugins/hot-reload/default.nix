{pkgs, lib, config, ...}:
{

  options = {
    reload.enable = lib.mkEnableOption "Enable hot reload nixvim plugin module";
  };

  config = lib.mkIf config.reload.enable {
  programs.nixvim = {
      extraConfigLua = ''
        require("hot-reload").setup({
        event = "BufEnter",
        reload_all = true,
        opts = function()
          local config_dir = vim.fn.stdpath("config")
          return {
          reload_files = {
            config_dir .. "init.lua",
          },
        }
        end
        })
        '';
    extraPlugins = [(pkgs.vimUtils.buildVimPlugin {
        name = "hot-reload";
        src = pkgs.fetchFromGitHub {
          owner = "Zeioth";
          repo = "hot-reload.nvim";
          rev = "9094182138635747158da64490a838ba46cf2d6c";
          hash = "sha256-2x/aKo1LIhslinqxtjvaU33Wo3zL4oj6HKZv41+sssA=";
        };
      })]; 
    };
  };
}
