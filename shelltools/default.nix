{
  lib,
  config,
  ...
}:
{
  imports = [
    ./atuin
    ./direnv 
    ./eza
    ./fzf
    ./zoxide
    ./zsh
  ];

  options = {
    shelltools.enable = lib.mkEnableOption "Enable shell tools module";
  };
  config = lib.mkIf config.devtooling.enable {
    atuin.enable = lib.mkDefault true;
    direnv.enable = lib.mkDefault true;
    eza.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    zoxide.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
  };
}
