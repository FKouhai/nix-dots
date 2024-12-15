{pkgs, lib, config, ...}:
{

  options = {
    git_helpers.enable = lib.mkEnableOption "Enable git nixvim plugins module";
  };

  config = lib.mkIf config.git_helpers.enable {
  programs.nixvim.plugins = {
    gitblame = {
      enable = true;
    };
    lazygit = {
      enable = true;
    };
    git-conflict = {
      enable = true;
      settings = {
        default_commands = true;
        default_mappings = {
          both = "b";
          next = "nn";
          none = "0";
          ours = "o";
          prev = "p";
          theirs = "t";
        };
        disable_diagnostics = false;
        highlights = {
          current = "DiffText";
          incoming = "DiffAdd";
        };
        list_opener = "copen";
      };
    };
   };
  };
}
