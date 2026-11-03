# Canonical kanoxo palettes for terminal themes.
# Mirrors ~/sw/kanoxo-colorscheme/lua/kanoxo/palette.lua (HEAD e60e88d).
# `termColors` mirrors the `terminal` table in lua/kanoxo/spec.lua
# (index 0-15) so kitty/ghostty stay in sync with Neovim's terminal colors.
{
  palettes = {
    wave = {
      bg = "#1c1c24";
      bg_dim = "#16161d";
      bg_dark = "#101014";
      bg_sel = "#2a2740";
      bg_float = "#232637";
      bg_menu = "#191922";
      border = "#3f3b5c";
      fg = "#dcd7ba";
      fg_dim = "#c8c4a0";
      fg_dark = "#76718d";
      red = "#e5486a";
      orange = "#e89060";
      yellow = "#d9a656";
      green = "#5cc070";
      teal = "#3fd0c9";
      blue = "#80aaff";
      purple = "#b08cf0";
      pink = "#e09ab5";
      red_br = "#f06080";
      green_br = "#72d888";
      yellow_br = "#e8bc6a";
      blue_br = "#9abcff";
      purple_br = "#c49cf8";
      teal_br = "#5fe0d8";
      white = "#dcd7ba";
      black = "#101014";
    };
    dragon = {
      bg = "#181616";
      bg_dim = "#131111";
      bg_dark = "#0e0c0c";
      bg_sel = "#2d2a2a";
      bg_float = "#221e1e";
      bg_menu = "#1b1919";
      border = "#453b3b";
      fg = "#cac8c0";
      fg_dim = "#b8b4ac";
      fg_dark = "#7c6c6c";
      red = "#c07070";
      orange = "#c08a5e";
      yellow = "#c4a882";
      green = "#8aaa8a";
      teal = "#6f9a8d";
      blue = "#8aa3b8";
      purple = "#9c8ec2";
      pink = "#c1949c";
      red_br = "#d48888";
      green_br = "#a3bfa3";
      yellow_br = "#d8bc98";
      blue_br = "#a3b8cc";
      purple_br = "#b3a6d4";
      teal_br = "#8ab5a8";
      white = "#cac8c0";
      black = "#0e0c0c";
    };
  };

  termColors = p: [
    p.black
    p.red
    p.green
    p.yellow
    p.blue
    p.purple
    p.teal
    p.fg_dim
    p.fg_dark
    p.red_br
    p.green_br
    p.yellow_br
    p.blue_br
    p.purple_br
    p.teal_br
    p.white
  ];
}
