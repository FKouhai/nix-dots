{
  lib,
  ...
}:
{
  imports = [
    ./noctalia
  ];

  options = {
    bars.enable = lib.mkEnableOption "Enable bars module";
  };

  config = {
    bars = {
      noctalia.enable = lib.mkDefault false;
    };
  };
}
