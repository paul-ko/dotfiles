# WSL non-apt installs

## Snaps
- uv: astral-uv
- neovim: nvim
  - available via apt, but version too old
- bash-language-server
  - sudo snap install bash-language-server --classic
  - Shellcheck diagnostics, shell autocomplete

## Cargo
- selene: specify --no-default-features
- treesitter
- stylua

## Other
- rust: rustup.rs
- nerd fonts: https://www.nerdfonts.com/font-downloads
- ruff: `uv tool install ruff@latest`
- go: https://go.dev/doc/install
- shfmt: `go install mvdan.cc/sh/v3/cmd/shfmt@latest`
