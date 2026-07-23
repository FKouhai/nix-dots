{
  lib,
  config,
  ...
}:
{
  imports = [
    ./starship
  ];

  options = {
    prompt.enable = lib.mkEnableOption "Enable prompt module";
  };
  config = lib.mkMerge [
    {
      prompt.enable = lib.mkDefault true;
    }
    (lib.mkIf config.prompt.enable {
      starship.enable = lib.mkDefault true;
    })
  ];
}
