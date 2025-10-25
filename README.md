# NixOS dotfiles
This repo contains the nix configurations for my main workstations
## How does the config looks like
![image ](./assets/tmux_btop.png)
![image](./assets/tmux_nvim.png)
![image](./assets/nitch_full_screen.png)
![Image](https://github.com/user-attachments/assets/27fbc144-2977-4a9e-bd4c-798ed0e07922)

## Structure

Under hosts I have the hardware and basic config of each of my hosts, these are divided by their hostname.
```
.
├── devtooling -> Direcotry that contains all the configs for my dev tools
│   ├── default.nix
│   ├── git
│   │   └── default.nix
│   ├── gleam
│   │   └── default.nix
│   ├── go
│   │   └── default.nix
│   ├── kubernetes
│   │   ├── default.nix
│   │   └── skin.yml
│   ├── lua
│   │   └── default.nix
│   ├── rust
│   │   └── default.nix
│   └── tmux
│       └── default.nix
├
├── flake.lock
├── flake.nix
├── gtk -> Needed gtk configs
│   ├── conf
│   │   └── default.nix
│   └── default.nix
├── home.nix
├── hosts
│   ├── franktory
│   │   └── etc
│   │       └── nixos
│   │           ├── configuration.nix
│   │           ├── hardware-configuration.nix
│   │           ├── wall-03.jpg
│   │           └── wp2.jpg
│   └── kraken
│       └── etc
│           └── nixos
│               ├── configuration.nix
│               ├── hardware-configuration.nix
│               ├── ollama.nix
│               ├── udev.nix
│               └── wp2.jpg
├── hypr.nix -> Hyrpland configuration
├── hyprpanel.nix -> currently not in use
├── keymaps.nix -> nvim keymaps
├── nixvim -> nvim configurations using nixvim
│   ├── default.nix
│   └── plugins
│       ├── blink
│       │   └── default.nix
│       ├── clipboard-image
│       │   └── default.nix
│       ├── cmp
│       │   └── default.nix
│       ├── code_companion
│       │   └── default.nix
│       ├── dashboard
│       │   └── default.nix
│       ├── git
│       │   └── default.nix
│       ├── harpoon
│       │   └── default.nix
│       ├── hot-reload
│       │   └── default.nix
│       ├── images
│       │   └── default.nix
│       ├── lint
│       │   └── default.nix
│       ├── lsp
│       │   └── default.nix
│       ├── lualine
│       │   └── default.nix
│       ├── luasnip
│       │   └── default.nix
│       ├── markdown-preview
│       │   └── default.nix
│       ├── oil
│       │   └── default.nix
│       ├── packer
│       │   └── default.nix
│       ├── presence
│       │   └── default.nix
│       ├── telekasten
│       │   └── default.nix
│       ├── telescope
│       │   └── default.nix
│       ├── toggleterm
│       │   └── default.nix
│       ├── tree-sitter
│       │   └── default.nix
│       ├── trouble
│       │   └── default.nix
│       └── which-key
│           └── default.nix
├── prompt -> prompt for zsh
│   ├── default.nix
│   └── starship
│       ├── default.nix
│       ├── kanagawa.nix
│       ├── oxocarbon.nix
│       ├── oxo.toml
│       └── tokyonight.nix
├── README.md
├── shelltools -> general tools I use within my terminal
│   ├── atuin
│   │   └── default.nix
│   ├── bat
│   │   └── default.nix
│   ├── default.nix
│   ├── direnv
│   │   └── default.nix
│   ├── eza
│   │   └── default.nix
│   ├── fzf
│   │   └── default.nix
│   ├── yazi
│   │   └── default.nix
│   ├── zoxide
│   │   └── default.nix
│   └── zsh
│       └── default.nix
└── vimopts.nix -> nvim options
```
