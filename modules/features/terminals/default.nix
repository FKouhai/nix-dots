{
  lib,
  config,
  ...
}:
{
  imports = [
    ./kitty.nix
    ./ghostty.nix
  ];

  options = {
    terminals.enable = lib.mkEnableOption "Enable terminals module";
  };
  config = lib.mkMerge [
    {
      terminals.enable = lib.mkDefault true;
    }
    (lib.mkIf config.terminals.enable {
      kitty.enable = lib.mkDefault true;
      ghostty.enable = lib.mkDefault true;
    })
  ];
}
