{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    starship.enable = lib.mkEnableOption "Enable starship module";
  };
  config = lib.mkIf config.starship.enable {
    programs.starship =
      let
        kanagawa = import ./kanagawa.nix;
      in
      {
        enable = true;
        enableZshIntegration = true;
        enableFishIntegration = true;
        settings = kanagawa;
      };
  };
}
