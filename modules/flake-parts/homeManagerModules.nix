_: {
  flake.homeManagerModules = {
    bars = import ../features/bars;
    barNoctalia = import ../features/bars/noctalia;
    desktops = import ../features/desktops/hyprland;
    devtooling = import ../features/devtooling;
    shelltools = import ../features/shelltools;
    prompt = import ../features/prompt;
    terminals = import ../features/terminals;
    stylix = import ../features/stylix;
    gtk = import ../features/gtk;
    flameshot = import ../features/flameshot.nix;
  };
}
