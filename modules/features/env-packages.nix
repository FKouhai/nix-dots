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
    inputs.zen-browser.packages.x86_64-linux.default
    inputs.agenix.packages.x86_64-linux.default
    inputs.trigo.packages.x86_64-linux.default
    (inputs.opencode.packages.x86_64-linux.opencode.overrideAttrs (old: {
      preBuild = (old.preBuild or "") + ''
        substituteInPlace packages/opencode/src/cli/cmd/generate.ts \
          --replace-fail 'const prettier = await import("prettier")' 'const prettier: any = { format: async (s: string) => s }' \
          --replace-fail 'const babel = await import("prettier/plugins/babel")' 'const babel = {}' \
          --replace-fail 'const estree = await import("prettier/plugins/estree")' 'const estree = {}'
      '';
    }))
    inputs.wallpapers.packages.x86_64-linux.default
    inputs.helium.defaultPackage.x86_64-linux
  ]
  ++ lib.optional (config.host.bar == "noctalia") inputs.noctalia.packages.x86_64-linux.default;
}
