# neovim configs

## Setting options
### Option overview
Options can be set at various levels.  Two are considered local:

- buffer: applies to that buffer only
- window: applies to that window only

The other, naturally, is global.

Each option supports either one or two of these scopes.  No option supports both window
and buffer, as far as I've seen documented.

There are five different setter functions.  Each of these has different effects on
different scopes.  These can result in different user experiences, e.g., a setter
function running before a new tab is created may or may not affect the new tab.

This is all an oversimplification because understanding this in detail would require
memorizing a massive matrix.

### Principles
In general, when setting an option, choose between `vim.opt` (`vim.o`) and
`vim.opt_local`.

- `vim.opt_local`
  - Use when you want to narrowly scope the option update
  - Requests local scope. For options with a local scope, this is honored exactly, and
    never affects the global default. For global-only options, there is no local scope
    to write to — the call falls back to writing global, the same as `vim.opt`.
- `vim.opt`
  - Use when you want to broadly scope the update
  - Modifies the global scope, and for non-global-only options, the window or buffer
    scope

Refer to the docs linked below if these don't sound like what you meant.

More specifically:
- ftplugins should avoid `vim.o` (`vim.opt`); instead, use `vim.opt_local` to scope
  effects as narrowly as possible.
  - Similarly, ftplugins should pass `{ buffer = true }` when setting keymaps.

### If things go wrong
- Check what setter is being called
- Use `setlocal [config]?`, `setglobal [config]?`, and `set [config]?` to check the
  current value in different scopes
  - e.g., `setglobal cursorline?`
- Use `help '[config]'` to check the variable's supported scope
  - e.g., `help cursorline`
- Test

### Documentation
See [local-options help](https://neovim.io/doc/user/options/#local-options) for details.

## Autocmds
### Principles
- Always add to a group that has has `{ clear = true }` as its second arg so re-sourcing
  the config doesn't add a duplicate copy of the autocmd.

## Keymaps
### Where to define
- If specific to an attach hook, define where that attach hook lives.  Examples:
  - autocmd.lua should contain autocmd's that define keymaps
  - `[plugin].lua` should contain keymaps specific to `[plugin]`'s attach hooks
- If executing the keymap should trigger a plugin to be lazily loaded, define in that
  plugin's `keys =` field to enable lazy.nvim
  to lazily define them when needed
- Otherwise, define in keymaps.lua
- `desc` option field should contain a clear description in its first 33 characters
  (fzf-lua `keymaps()` constraint)

## LSPs

### Adding an LSP
See the instructions in the *Plugins* > *nvim-lspconfig* > *Details* section.

### Plugins

#### nvim-lspconfig
##### Status
**Installed.**

##### Details
[GitHub](https://github.com/neovim/nvim-lspconfig)

Community-sourced configurations for various language servers.

To set up a server (copied from its README as of `7ab79bb`):

---

1. Install a language server, e.g. [pyright](doc/configs.md#pyright)
   ```bash
   npm i -g pyright
   ```
2. Enable its config in your init.lua ([:help lsp-quickstart](https://neovim.io/doc/user/lsp.html#lsp-quickstart)).
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

#### mason

##### Status
**Not installed**
For the current use case, auto-install of language server binaries is not high value
enough to justify adding another package manager into the setup.

##### Details
[GitHub](https://github.com/mason-org/mason.nvim)

Package manager for neovim tooling; not LSP-specific but relevant.

#### mason-lspconfig

##### Status
**Not installed**
No value unless/until mason is installed; possibly fairly low-value even then (see
README quote below).  It also automatically enables any language server installed by
mason, and doesn't generate a lockfile (although it supports version pinning).

##### Details
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
