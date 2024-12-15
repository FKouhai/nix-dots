{pkgs, lib, config, ...}:
{
  options = {
    telekasten.enable = lib.mkEnableOption "Enable telekasten nixvim plugin module";
  };

  config = lib.mkIf config.telekasten.enable {
  programs.nixvim.plugins.telekasten = {
    enable = true;
    settings = {
        home = {
          __raw  = "vim.fn.expand(\"~/vaults/personal/notes/\")";
        };
        image_subdir = {
          __raw = "vim.fn.expand(\"~/vaults/personal/assets/imgs\")";
        };
      };
  };
 };
}
