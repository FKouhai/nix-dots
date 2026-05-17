# NixOS dotfiles

This repo contains the NixOS + Home Manager configurations for my main workstations.

## Screenshots

![Glance](./assets/glance.png)
![image ](./assets/tmux_btop.png)
![image](./assets/tmux_nvim.png)
![image](./assets/nitch_full_screen.png)
![Image](https://github.com/user-attachments/assets/27fbc144-2977-4a9e-bd4c-798ed0e07922)

## Hosts

| Host | Type | Resolution | Bar | Kernel |
|------|------|------------|-----|--------|
| **franktory** | Laptop | 1920×1080 | noctalia | linux-latest |
| **kraken** | Desktop (dual monitor) | 2×2560×1440 | noctalia | CachyOS |

## Commands

```bash
# Rebuild and switch the full system
nh os switch ~/.config/home-manager

# Rebuild with flake update
nh os switch ~/.config/home-manager --update

# Home Manager only (user-space changes, faster)
home-manager switch

# Format all Nix files
treefmt

# Garbage collect old generations
nh clean all -v
```

## Architecture

The config uses the **dendritic pattern** with [flake-parts](https://github.com/hercules-ci/flake-parts) and [import-tree](https://github.com/vic/import-tree).

- `flake.nix` is a minimal wrapper; `import-tree` auto-discovers modules from three directories:
  - `modules/hosts/` — per-host NixOS configs → `flake.nixosModules.*` / `flake.nixosConfigurations.*`
  - `modules/services/` — reusable NixOS service modules → `flake.nixosModules.*`
  - `modules/flake-parts/` — flake-level exports → `flake.homeManagerModules.*`
- Host-specific data is exposed via typed NixOS options at `options.host.*`; HM modules access them via `osConfig.host.*`
- Shared HM feature modules live in `modules/features/` and are imported explicitly by `modules/home.nix`

## Structure

```
.
|--README.md
|--flake.lock
|--flake.nix
|--modules
|   |--features
|   |   |--bars
|   |   |   |--caelestia.nix
|   |   |   |--default.nix
|   |   |   |--hyprpanel.nix
|   |   |   L__noctalia
|   |   |       |--default.nix
|   |   |       |--settings
|   |   |       |   |--bar.nix
|   |   |       |   L__default.nix
|   |   |       L__themes.nix
|   |   |--desktops
|   |   |   L__hyprland
|   |   |       |--config
|   |   |       |   |--animations.nix
|   |   |       |   |--bindings.nix
|   |   |       |   |--decoration.nix
|   |   |       |   |--exec.nix
|   |   |       |   |--general.nix
|   |   |       |   |--gestures.nix
|   |   |       |   L__windowrules.nix
|   |   |       |--default.nix
|   |   |       |--hypr.nix
|   |   |       |--hyprlock.nix
|   |   |       |--hyprpaper.nix
|   |   |       L__wlogout.nix
|   |   |--devtooling
|   |   |   |--default.nix
|   |   |   |--git
|   |   |   |   L__default.nix
|   |   |   |--gleam
|   |   |   |   L__default.nix
|   |   |   |--go
|   |   |   |   L__default.nix
|   |   |   |--kubernetes
|   |   |   |   |--default.nix
|   |   |   |   L__skin.yml
|   |   |   |--lua
|   |   |   |   L__default.nix
|   |   |   |--nixvim
|   |   |   |   L__default.nix
|   |   |   |--rust
|   |   |   |   L__default.nix
|   |   |   L__tmux
|   |   |       L__default.nix
|   |   |--env-packages.nix
|   |   |--fish-config.nix
|   |   |--flameshot.nix
|   |   |--gtk
|   |   |   |--conf
|   |   |   |   L__default.nix
|   |   |   L__default.nix
|   |   |--host-options.nix
|   |   |--nix-config.nix
|   |   |--prompt
|   |   |   |--default.nix
|   |   |   L__starship
|   |   |       |--default.nix
|   |   |       |--kanagawa.nix
|   |   |       |--oxo.toml
|   |   |       |--oxocarbon.nix
|   |   |       L__tokyonight.nix
|   |   |--shelltools
|   |   |   |--atuin
|   |   |   |   L__default.nix
|   |   |   |--bat
|   |   |   |   L__default.nix
|   |   |   |--default.nix
|   |   |   |--direnv
|   |   |   |   L__default.nix
|   |   |   |--eza
|   |   |   |   L__default.nix
|   |   |   |--fish
|   |   |   |   L__default.nix
|   |   |   |--fzf
|   |   |   |   L__default.nix
|   |   |   |--yazi
|   |   |   |   L__default.nix
|   |   |   |--zoxide
|   |   |   |   L__default.nix
|   |   |   L__zsh
|   |   |       L__default.nix
|   |   |--stylix
|   |   |   L__default.nix
|   |   L__terminals
|   |       |--default.nix
|   |       |--ghostty.nix
|   |       L__kitty.nix
|   |--flake-parts
|   |   L__homeManagerModules.nix
|   |--home.nix
|   |--hosts
|   |   |--franktory
|   |   |   |--configuration.nix
|   |   |   |--default.nix
|   |   |   L__hardware-configuration.nix
|   |   L__kraken
|   |       |--configuration.nix
|   |       |--default.nix
|   |       |--hardware-configuration.nix
|   |       |--logiops.nix
|   |       L__udev.nix
|   |--packages.nix
|   L__services
|       |--glance.nix
|       |--gpu.nix
|       |--greeter.nix
|       |--ollama.nix
|       |--otel.nix
|       |--prometheus.nix
|       L__theme-data.nix
|--secrets
|   |--gemini.age
|   |--grafana.age
|   |--ollama.age
|   L__secrets.nix
L__treefmt.toml
```

## Key concepts

### Host options (`options.host.*`)

Each host sets these in its `configuration.nix`. HM modules access them via `osConfig.host.*`.

| Option | Type | Description |
|--------|------|-------------|
| `host.hostName` | `str` | Hostname |
| `host.isDesktop` | `bool` | Whether the machine is a desktop |
| `host.class` | `enum [laptop desktop]` | Form factor |
| `host.bar` | `enum [noctalia caelestia hyprpanel]` | Desktop panel |
| `host.greeter` | `enum [greetd sddm]` | Display manager / greeter (default: `greetd`) |
| `host.gpuType` | `enum [amd nvidia none]` | GPU vendor for driver + tool selection (default: `none`) |
| `host.theme` | `enum [kanagawa-dragon kanagawa-wave kanagawa-aqua]` | System color theme (default: `kanagawa-dragon`) |
| `host.themeData` | `attrs` (read-only) | Computed color data derived from `host.theme`; set by `nixosModules.themeData` |
| `host.wallpaper` | `path` | Wallpaper path |
| `host.mainMonitor` | `{ name, width, height, refresh }` | Primary monitor |
| `host.secondaryMonitor` | `{ name, width, height, refresh }` | Secondary monitor |

### Reusable NixOS modules (`flake.nixosModules.*`)

Generic service modules in `modules/services/` can be included in any host's `default.nix`:

| Module | What it provides |
|--------|-----------------|
| `nixosModules.themeData` | Computes `host.themeData` from `host.theme`; required for all themed HM modules |
| `nixosModules.gpu` | `hardware.amdgpu` + `lact` + `nvtopPackages.amd` when `gpuType = "amd"`; `hardware.nvidia` + `nvtopPackages.nvidia` when `gpuType = "nvidia"`; `hardware.graphics` always |
| `nixosModules.greeter` | greetd/tuigreet when `greeter = "greetd"`; SDDM astronaut theme when `greeter = "sddm"` |
| `nixosModules.ollama` | Ollama service; selects `ollama-rocm` / `ollama-cuda` / `ollama` based on `gpuType` |
| `nixosModules.glance` | Glance dashboard on port 8080 |
| `nixosModules.otel` | OpenTelemetry collector (exports to `otelcollector.universe.home`) |
| `nixosModules.prometheus` | Prometheus node exporter + Promtail (uses `host.hostName` as log label) |

### Themes

Set `host.theme` in a host's `configuration.nix` to switch the full color scheme. The `nixosModules.themeData` module must be included in the host's modules list.

| Theme | Background | Style | Drives |
|-------|-----------|-------|--------|
| `kanagawa-dragon` | `#181616` | Dark warm grey | stylix base16, kitty (`kanagawa_dragon`), ghostty, GTK (`Kanagawa-B`), tmux (`kanagawa/dragon`) |
| `kanagawa-wave` | `#1F1F28` | Dark blue-black | stylix base16, kitty (`kanagawa`), ghostty, GTK (`Kanagawa`), tmux (`kanagawa/wave`) |
| `kanagawa-aqua` | `#12141c` | Dark teal-tinted (custom) | stylix base16 (inline), kitty (`kanagawa_dragon`), ghostty (custom aqua palette), GTK (`Kanagawa-B`), tmux (`kanagawa/dragon`) |

All color data is stored as inline base16 attrsets in `modules/services/theme-data.nix` — no external YAML files needed. Bars (noctalia, hyprpanel) derive colors from the wallpaper via matugen and auto-adjust independently.

### Home Manager modules (`flake.homeManagerModules.*`)

All HM feature modules are exported for reuse by other flakes. Add them to `home-manager.sharedModules` or `home-manager.users.<name>`:

| Module | What it provides |
|--------|-----------------|
| `homeManagerModules.bars` | All bars bundle (selects active bar via `osConfig.host.bar`) |
| `homeManagerModules.barNoctalia` | Noctalia shell bar; auto-generates Vesktop + Cider themes from wallpaper colors on change |
| `homeManagerModules.barCaelestia` | Caelestia shell bar |
| `homeManagerModules.barHyprpanel` | Hyprpanel bar |
| `homeManagerModules.desktops` | Hyprland + hyprlock + hyprpaper + wlogout |
| `homeManagerModules.devtooling` | git, rust, go, lua, gleam, kubernetes, tmux, nixvim |
| `homeManagerModules.shelltools` | fish, zsh, fzf, eza, bat, direnv, atuin, yazi, zoxide |
| `homeManagerModules.prompt` | Starship prompt |
| `homeManagerModules.terminals` | kitty + ghostty |
| `homeManagerModules.stylix` | Kanagawa Dragon base16 theming |
| `homeManagerModules.gtk` | GTK theme config |
| `homeManagerModules.flameshot` | Screenshot tool |

> **Note:** Bar modules require `host-options.nix` as a NixOS module and home-manager used as a NixOS module (not standalone), since they reference `osConfig.host.*`.

> **Note:** `nix flake show` displays `homeManagerModules: unknown` — this is expected; `homeManagerModules` is not a standard flake output type that nix knows how to introspect. The modules are accessible and functional. Verify with: `nix eval .#homeManagerModules --apply builtins.attrNames`

### Module pattern

Every feature module follows this structure:

```nix
{ lib, config, ... }: {
  options.MODULE.enable = lib.mkEnableOption "...";
  config = lib.mkIf config.MODULE.enable { ... };
}
```

Parent modules import sub-modules and enable them by default when the parent is enabled.

### Flake-provided packages

Non-nixpkgs packages injected via `modules/features/env-packages.nix`:

| Input | Package |
|-------|---------|
| `zen-browser` | Browser |
| `helium` | helium2nix custom tool |
| `agenix` | Secret management CLI |
| `opencode` | AI coding assistant |
| `wallpapers` | Kanagawa wallpaper collection |
| `caelestia-shell` / `noctalia` | Desktop panel (selected by `host.bar`) |
| `trigo` | File tree CLI (`trigo`) |

### Secrets

Encrypted with [agenix](https://github.com/ryantm/agenix). Files in `secrets/` are `.age` blobs. `secrets/secrets.nix` declares which SSH public keys can decrypt each secret. Decryption requires the corresponding private key at runtime.
