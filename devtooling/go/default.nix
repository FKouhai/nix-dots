{pkgs,lib,config, ...}:
{
  options = {
    go.enable = lib.mkEnableOption "Enable go module";
  };
  config = lib.mkIf config.go.enable {
    home.packages = with pkgs; [
        go
        gopls
        gotestsum
        mockgen
        gofumpt
        golines
        govulncheck
        gomodifytags
        gotools
        gotests
        iferr
        ginkgo
        delve
        richgo
        impl
        golangci-lint
      ];
  };
}
