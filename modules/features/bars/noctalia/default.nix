{
  lib,
  config,
  osConfig,
  ...
}:
{
  imports = [
    ./themes.nix
    ./settings/bar.nix
    ./settings/default.nix
  ];

  options = {
    bars.noctalia.enable = lib.mkEnableOption "Enable noctalia bar";
  };

  config = lib.mkIf config.bars.noctalia.enable {
    programs.noctalia-shell = {
      enable = lib.mkIf (osConfig.host.bar == "noctalia") true;
    };
  };
}
