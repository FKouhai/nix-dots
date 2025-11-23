{
  lib,
  config,
  ...
}:
{
  imports = [
    ./kitty.nix
  ];

  options = {
    terminals.enable = lib.mkEnableOption "Enable terminals module";
  };
  config = lib.mkIf config.terminals.enable {
    kitty.enable = lib.mkDefault true;
  };
}