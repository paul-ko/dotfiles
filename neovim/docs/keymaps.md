# Keymaps

## How to define

### Keystrokes
```lua
vim.keymap.set({ "n", "v" }, "k", "gk")
```

### Lua function (direct call, no args)

### Lua function
```lua
{
  groups.word .. "a",
  function()
    return Snacks.picker.grep_word()
  end,
  desc = "word: all",
}
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
- `<leader>b`: buffer management
- `<leader>c`: code (LSP actions)
- `<leader>d`: delete files/directories (reserved, unused so far)
- `<leader>f`: fuzzy-find files, by category (see below)
- `<leader>g`: live-grep file content, by category (see below)
- `<leader>G`: git
- `<leader>p`: persistence (sessions)
- `<leader>t`: toggle
- `<leader>w`: search the word under the cursor, by category (see below)
- `<leader><leader>`: muscle memory

The `f`/`g`/`w` groups share a consistent category taxonomy as their second
character, defined in `lua/file_categories.lua`:
- `C`: config files
- `d`: docs
- `s`: structured files (csv/json/toml/yaml)
- `u`: other/uncategorized (e.g. `LICENSE`, lockfiles)
- `c`: code (everything not matching another category)
- `a`: all files, unfiltered

e.g. `,fd` fuzzy-finds doc files, `,wC` searches for the word under the cursor in
config files, `,gs` live-greps structured files.
