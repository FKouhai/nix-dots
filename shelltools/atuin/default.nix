{lib, config, ...}:
{

  options = {
    atuin.enable = lib.mkEnableOption "Enable atuin module";
  };

  config = lib.mkIf config.atuin.enable {
    programs.atuin = {
      enable = true;
      enableZshIntegration = true;
      flags = ["--disable-up-arrow"];
      settings = {
        update_check = false;
        search_mode = "fuzzy";
        inline_height = 33;
        common_prefix = ["sudo"];
        dialect = "us";
        workspaces = "true";
        filter_mode = "host";
        filter_node_shell_up_keybinding = "session";
        history_filter = ["^ "];
      };
    };

  };

}
