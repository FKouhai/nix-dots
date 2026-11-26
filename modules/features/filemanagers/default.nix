{ lib, config, ... }:
{
  imports = [
    ./nemo
  ];

  options = {
    filemanagers.enable = lib.mkEnableOption "Enable file managers module";
  };

  config = lib.mkMerge [
    {
      filemanagers.enable = lib.mkDefault true;
    }
    (lib.mkIf config.filemanagers.enable {
      filemanagers.nemo.enable = lib.mkDefault true;
    })
  ];
}
