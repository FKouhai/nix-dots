{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
{
  options = {
    stylix-mod.enable = lib.mkEnableOption "Enable stylix module";
  };
  config = lib.mkMerge [
    {
      stylix-mod.enable = lib.mkDefault true;
    }
    (lib.mkIf config.stylix-mod.enable {
      stylix = {
        autoEnable = false;
        enable = true;
        base16Scheme = {
          scheme = "Kanagawa Dragon";
          author = "rebelot";
          base00 = "181616";
          base01 = "1f1c1c";
          base02 = "282727";
          base03 = "625e5a";
          base04 = "a6a69c";
          base05 = "c5c9c5";
          base06 = "c8c093";
          base07 = "dcd7ba";
          base08 = "c4746e";
          base09 = "b6927b";
          base0A = "c4b28a";
          base0B = "8a9a7b";
          base0C = "8ea4a2";
          base0D = "8ba4b0";
          base0E = "a292a3";
          base0F = "c4b28a";
        };
        targets = {
          bat.enable = true;
          btop.enable = false;
          gtk.enable = false;
          hyprland.enable = false;
          k9s.enable = true;
          kubecolor.enable = true;
          lazygit.enable = false;
          mpv.enable = true;
          opencode.enable = true;
          vesktop.enable = true;
          wofi.enable = true;
        };
      };
    })
  ];
}
