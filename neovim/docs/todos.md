# Things to figure out or do in neovim

## List

### High priority
- FzfLua
  - git_commits, git_bcommits
- nvim-tree keymaps?
- Gitsigns
  - blame, diffthis
- Learn about highlight groups

### Medium priority
- Conform instead of neoformat
- Reserve `<leader>dd` since I keep typing it and deleting lines
- Review the plugins list in dracula's README config
- More mini.nvim modules
- See if there's a way

### Low priority
- Custom help for key stuff to remember
- Helper to surface my user-defined commands
- Use `opt` instead of `config` in more plugin specs
- Explore closure-based redesign of `exfzf` (see **A1**)

## Appendices

### A1. Closure-based redesign of `exfzf`

```lua
local function exfzf(method, arg_fn)
  return function()
    local args = arg_fn and arg_fn() or {}
    require("fzf-lua")[method](unpack(args))
  end
end
```
