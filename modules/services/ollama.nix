_: {
  flake.nixosModules.ollama =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      services.ollama = {
        enable = true;
        port = 11434;
        host = "0.0.0.0";
        openFirewall = true;
        package =
          if config.host.gpuType == "amd" then
            pkgs.ollama-rocm
          else if config.host.gpuType == "nvidia" then
            pkgs.ollama-cuda
          else
            pkgs.ollama;
      };

    };
}
