{
  lib,
  config,
  ...
}:
{
  imports = [
    ./atuin
    ./bat
    ./direnv
    ./eza
    ./fastfetch
    ./fish
    ./fzf
    ./zoxide
    ./zsh
    ./yazi
  ];

  options = {
    shelltools.enable = lib.mkEnableOption "Enable shell tools module";
  };
  config = lib.mkIf config.devtooling.enable {
    atuin.enable = lib.mkDefault true;
    fastfetch.enable = lib.mkDefault true;
    bat.enable = lib.mkDefault true;
    direnv.enable = lib.mkDefault true;
    eza.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    zoxide.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
    fish.enable = lib.mkDefault true;
    yazi.enable = lib.mkDefault true;
  };
}
