# Keymaps

## How to define

### Keystrokes
```lua
vim.keymap.set({ "n", "v" }, "k", "gk")
```

### Lua function (direct call, no args)

### Lua function
```lua
exfzf(
  "grep",
  function() return { search = vim.fn.expand("<cword>") } end
)
```

### Run Ex command
```lua
vim.keymap.set(
  "n",
  keymap_groups.buffers .. "b",
  utils.excmd("b#"),
  { desc = "back to prev buffer (b#, not stack)" }
)
```

## Where to define
- If specific to an attach hook, define where that attach hook lives.  Examples:
  - autocmd.lua should contain autocmd's that define keymaps
  - `[plugin].lua` should contain keymaps specific to `[plugin]`'s attach hooks
- If executing the keymap should trigger a plugin to be lazily loaded, define in that
  plugin's `keys =` field to enable lazy.nvim
  to lazily define them when needed
- Otherwise, define in keymaps.lua
- `desc` option field should contain a clear description in its first 33 characters
  (fzf-lua `keymaps()` constraint)

## Grouping
Keymaps are organized using grouping, where keymaps related to a specific concern share the same starting character.  This improves discoverability, particularly with which-key installed.  <!-- The grouping `<leader>[group][key]`, where `[group]` is a single character identifying the  -->

### Groups
- `<leader>d`: diagnostics
- `<leader>f`: find files/directories
- `<leader>g`: git
- `<leader>s`: searches
- `<leader><leader>`: muscle memory
