# LSPs

## Adding an LSP
See the instructions in the *Plugins* > *nvim-lspconfig* > *Details* section.

## Plugins

### nvim-lspconfig
#### Status
**Installed.**

#### Details
[GitHub](https://github.com/neovim/nvim-lspconfig)

Community-sourced configurations for various language servers.

To set up a server (copied from its README as of `7ab79bb`):



1. Install a language server, e.g. [pyright](doc/configs.md#pyright)
   ```bash
   npm i -g pyright
   ```
2. Enable its config in lsp.lua ([:help lsp-quickstart](https://neovim.io/doc/user/lsp.html#lsp-quickstart)).
   ```lua
   vim.lsp.enable('pyright')
   ```
3. Ensure your project/workspace contains a root marker as specified in `:help lspconfig-all`.
4. Open a code file in Nvim. LSP will attach and provide diagnostics.
   ```
   nvim main.py
   ```
5. Run `:checkhealth vim.lsp` to see the status or to troubleshoot.

See `:help lspconfig-all` for the full list of server-specific details. For
servers not on your `$PATH` (e.g., `jdtls`, `elixirls`), you must manually set
the `cmd` parameter:

```lua
vim.lsp.config('jdtls', {
  cmd = { '/path/to/jdtls' },
})
```
---

### mason

#### Status
**Not installed**
For the current use case, auto-install of language server binaries is not high value
enough to justify adding another package manager into the setup.

#### Details
[GitHub](https://github.com/mason-org/mason.nvim)

Package manager for neovim tooling; not LSP-specific but relevant.

### mason-lspconfig

#### Status
**Not installed**
No value unless/until mason is installed; possibly fairly low-value even then (see
README quote below).  It also automatically enables any language server installed by
mason, and doesn't generate a lockfile (although it supports version pinning).

#### Details
[GitHub](https://github.com/mason-org/mason-lspconfig.nvim)

Sort of a bridge between mason and nvim-lspconfig.  Some of its capabilities are:

- Auto-install of language servers that are enabled via nvim-lspconfig
- Translation layer between mason package names and nvim-lspconfig server names

From its README as of (`7adc933`):

---

This plugin's main responsibilities are to:

- allow you to (i) automatically install, and (ii) automatically enable (`vim.lsp.enable()`) installed servers
- provide extra convenience APIs such as the `:LspInstall` command
- provide additional LSP configurations for a few servers
- translate between `nvim-lspconfig` server names and `mason.nvim` package names (e.g. `lua_ls <-> lua-language-server`)

> [!NOTE]
> Since the introduction of [`:h vim.lsp.config`](https://neovim.io/doc/user/lsp.html#vim.lsp.config()) in Neovim 0.11,
> this plugin's feature set has been reduced. Use this plugin if you want to automatically enable installed servers
> ([`:h vim.lsp.enable()`](https://neovim.io/doc/user/lsp.html#vim.lsp.enable())) or have access to the `:LspInstall`
> command.

---
