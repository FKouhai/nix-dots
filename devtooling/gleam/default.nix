{pkgs, lib, config, ...}:
{
  options = {
    gleam.enable = lib.mkEnableOption "Enable gleam module";
  };
  config = lib.mkIf config.gleam.enable{
    home.packages = with pkgs; [
        gleam
        erlang
      ];
  };
}
