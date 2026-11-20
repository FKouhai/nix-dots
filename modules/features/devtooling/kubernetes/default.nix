{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    kubernetes.enable = lib.mkEnableOption "Enable kubernetes option";
  };
  config = lib.mkIf config.kubernetes.enable {
    home.packages = with pkgs; [
      kubectl
      kubectx
      kubelogin-oidc
      (writeShellScriptBin "oidc-login" ''
        exec ${kubelogin-oidc}/bin/kubectl-oidc_login "$@"
      '')
    ];
    programs.k9s = {
      enable = true;
    };
  };
}
