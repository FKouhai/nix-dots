{
  lib,
  config,
  ...
}:
{
  options = {
    atuin.enable = lib.mkEnableOption "Enable atuin module";
  };

  config = lib.mkIf config.atuin.enable {
    programs.atuin = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      flags = [ "--disable-up-arrow" ];
      settings = {
        update_check = false;
        search_mode = "fuzzy";
        inline_height = 33;
        common_prefix = [ "sudo" ];
        dialect = "us";
        workspaces = true;
        filter_mode = "host";
        filter_mode_shell_up_keybinding = "session";
        history_filter = [ "^ " ];
        style = "compact";
        sync_address = "https://atuin.tailde593.ts.net";
        sync_frequency = "10m";
      };
    };
  };
}
