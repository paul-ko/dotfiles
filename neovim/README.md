# neovim configs

## Principles
- ftplugins should avoid `vim.o` (`vim.opt`); instead, use `vim.opt_local`, `vim.bo`, or
  `vim.wo`.
- Similarly, they should pass `{ buffer = true }` when setting keymaps.

## Config setters
See [local-options help](https://neovim.io/doc/user/options/#local-options) for details.

- `vim.o`: use when you want the config to be applied to be applied as broadly as
  possible, potentially outside of the currently open window or buffer
- `vim.opt_local`: use when you want the config to be applied narrowly.
    - Note that for window configs, new windows created by splitting the current window
      will still inherit values set this way.
- `vim.bo`: use when you want the config to be applied to the current buffer only.  Only
  works for local-to-buffer and global-or-local configs.
- `vim.wo`: use when you want the config to be applied to the current window only.  Only
  works for local-to-window and global-or-local configs.
    - Note that for window configs, new windows created by splitting the current window
      will still inherit values set this way.

