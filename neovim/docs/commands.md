# Commands

## Examples
Closes the current buffer and opens a previous one:

```lua
vim.api.nvim_create_user_command("Close", function()
  local buf_to_delete = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()

  local alt = vim.fn.bufnr("#")
  if alt ~= buf_to_delete and alt ~= -1 and vim.fn.buflisted(alt) == 1 then
    vim.api.nvim_win_set_buf(win, alt)
  else
    vim.cmd("bprevious")
  end

  if vim.api.nvim_get_current_buf() == buf_to_delete then
    vim.cmd("enew") -- nothing else to switch to; don't delete out from under ourselves
  end

  vim.api.nvim_buf_delete(buf_to_delete, {})
end, {})
```
