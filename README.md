# NixOS dotfiles

## Structure
Under etc/nixos theres the configs managed by nixos itself with a flake that contains:
 * Current config
 * zen-browser installation

devtooling:
*   git/ -> my personal git config
*   gleam/ -> installs gleam and erlang_26
*   go/ -> installs the latest go version and its lsp
*   kubernetes/ -> installs k9s and sets up a skin
*   lua/ -> installs the lua language server
*   rust/ -> installs cargo and rust-analyzer

prompt:
*   starship/ -> sets up starship as the prompt for the shell
shelltools:
*   atuin/ -> install atuin
*   direnv/ -> sets up direnv (pretty useful for devbox)
*   eza/ -> installs and sets up eza
*   fzf/ -> installs fzf
*   zoxide/ -> installs zoxide
*   zsh/ -> installs and sets up zsh
