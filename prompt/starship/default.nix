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
        oxo = import ./oxocarbon.nix;
      in
      {
        enable = true;
        enableZshIntegration = true;
        settings = oxo;
      };
  };
}
