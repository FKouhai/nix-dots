{
  lib,
  config,
  ...
}:
{
  imports = [
    ./git
    ./go
    ./kubernetes
    ./nixvim
    ./rust
    ./tmux
  ];

  options = {
    devtooling.enable = lib.mkEnableOption "Enable devtooling module";
  };
  config = lib.mkMerge [
    {
      devtooling.enable = lib.mkDefault true;
    }
    (lib.mkIf config.devtooling.enable {
      git.enable = lib.mkDefault true;
      go.enable = lib.mkDefault true;
      kubernetes.enable = lib.mkDefault true;
      nixvim.enable = lib.mkDefault true;
      rust.enable = lib.mkDefault true;
      tmux.enable = lib.mkDefault true;
    })
  ];
}
