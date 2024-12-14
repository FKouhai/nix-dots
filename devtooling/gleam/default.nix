{pkgs, lib, config, ...}:
{
  options = {
    gleam.enable = lib.mkEnableOption "Enable gleam module";
  };
  config = lib.mkIf config.gleam.enable{
    home.packages = with pkgs; [
        gleam
        rebar3
        erlang_26 # there seems to be an issue with erlang27(latest version) where gleam tends to fail on running any project https://forum.exercism.org/t/escript-error-in-gleam-exercise/11486
      ];
  };
}
