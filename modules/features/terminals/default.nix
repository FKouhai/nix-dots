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
    terminals.variant = lib.mkOption {
      type = lib.types.enum [
        "dragon"
        "wave"
      ];
      default = "wave";
      description = "Kanoxo colorscheme variant for kitty and ghostty (matches nixvim).";
    };
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
