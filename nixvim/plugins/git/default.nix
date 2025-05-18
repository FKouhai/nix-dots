{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    git_helpers.enable = lib.mkEnableOption "Enable git nixvim plugins module";
  };

  config = lib.mkIf config.git_helpers.enable {
    programs.nixvim.plugins = {
      git-worktree = {
        enable = true;
        enableTelescope = true;
        settings = {
          update_on_change = true;
        };
      };
      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
          current_line_blame_opts = {
            virt_text = true;
            virt_text_pos = "eol";
          };
          signcolumn = true;
          watch_gitdir = {
            follow_files = true;
          };
        };
      };
      lazygit = {
        enable = true;
      };
      fugit2 = {
        enable = true;
      };
      fugitive.enable = true;
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
