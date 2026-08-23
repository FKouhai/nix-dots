{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = [
    pkgs.ghostty
    pkgs.kitty
    inputs.zen-browser.packages.x86_64-linux.default
    inputs.agenix.packages.x86_64-linux.default
    inputs.trigo.packages.x86_64-linux.default
    inputs.aphelion.packages.x86_64-linux.default
    inputs.llm.packages.x86_64-linux.opencode
    inputs.llm.packages.x86_64-linux.pi
    inputs.wallpapers.packages.x86_64-linux.default
    (inputs.helium.helium.x86_64-linux {
      enableFeatures = [
        "WaylandLinuxDrmSyncObj"
        "VaapiVideoDecoder"
        "Vulkan"
        "VulkanFromANGLE"
        "DefaultANGLEVulkan"
      ];
      commandLineArgs = [
        "--ozone-platform=wayland"
        "--ignore-gpu-blocklist"
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
      ];
    })
    inputs.noctalia.packages.x86_64-linux.default
  ];
}
