{pkgs, lib, config, ...}:
{

  options = {
    telescope.enable = lib.mkEnableOption "Enable telescope nixvim plugin module";
  };

  config = lib.mkIf config.telescope.enable {
  programs.nixvim.plugins.telescope = {
    enable = true;
    settings.defaults = {
      file_ignore_patterns = [
        "^.git/"
        "^.mypy_cache/"
        "^__pycache__/"
        "^output/"
        "^data/"
        "%.ipynb"
      ];
      set_env.COLORTERM = "truecolor";
    };
  };
 };
}
