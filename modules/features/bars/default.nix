{
  lib,
  config,
  osConfig ? { },
  ...
}:
{
  imports = [
    ./noctalia
  ];

  options = {
    bars.enable = lib.mkEnableOption "Enable bars module";
  };

  config = lib.mkMerge [
    {
      bars = {
        enable = lib.mkDefault true;
        noctalia.enable = lib.mkDefault true;
      };
    }
  ];
}
