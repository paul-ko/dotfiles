-- Folds away comment-only lines (via treesitter) so more code fits on screen.
-- Trailing end-of-line comments are left alone: a fold covers whole lines, so a
-- comment sharing a line with code can't be collapsed without also hiding that code.
local M = {}

local function whole_line_comment_ranges(bufnr)
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok or not parser then
    return nil
  end

  local comment_lines = {}
  local function visit(node, bnr)
    if node:type():match("comment") then
      local srow, scol, erow, ecol = node:range()
      local start_line = vim.api.nvim_buf_get_lines(bnr, srow, srow + 1, false)[1] or ""
      local end_line = vim.api.nvim_buf_get_lines(bnr, erow, erow + 1, false)[1] or ""
      local before = start_line:sub(1, scol)
      local after = end_line:sub(ecol + 1)
      if before:match("^%s*$") and after:match("^%s*$") then
        for l = srow, erow do
          comment_lines[l] = true
        end
      end
    end
    for child in node:iter_children() do
      visit(child, bnr)
    end
  end

  parser:parse(true)
  parser:for_each_tree(function(tree)
    visit(tree:root(), bufnr)
  end)

  local sorted = {}
  for l in pairs(comment_lines) do
    table.insert(sorted, l)
  end
  table.sort(sorted)

  local ranges = {}
  local i = 1
  while i <= #sorted do
    local s = sorted[i]
    local e = s
    while sorted[i + 1] == e + 1 do
      i = i + 1
      e = sorted[i]
    end
    table.insert(ranges, { s, e })
    i = i + 1
  end
  return ranges
end

-- Links dynamically, so it follows Comment (and colorscheme changes) at
-- render time rather than freezing today's color.
vim.api.nvim_set_hl(0, "CommentFold", { link = "Comment", default = true })

-- Folds are window-local, so toggling in one window won't affect another
-- window on the same buffer.
function M.toggle()
  local win = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_get_current_buf()

  if vim.w[win].comment_fold_prev_foldmethod then
    vim.wo[win].foldmethod = vim.w[win].comment_fold_prev_foldmethod
    vim.w[win].comment_fold_prev_foldmethod = nil
    vim.wo[win].winhighlight = vim.w[win].comment_fold_prev_winhighlight
    vim.w[win].comment_fold_prev_winhighlight = nil
    return
  end

  local ranges = whole_line_comment_ranges(bufnr)
  if not ranges then
    vim.notify("No treesitter parser for this buffer", vim.log.levels.WARN)
    return
  end
  if #ranges == 0 then
    vim.notify("No comment-only lines found", vim.log.levels.INFO)
    return
  end

  vim.w[win].comment_fold_prev_foldmethod = vim.wo[win].foldmethod
  vim.wo[win].foldmethod = "manual"

  vim.w[win].comment_fold_prev_winhighlight = vim.wo[win].winhighlight
  local wh = vim.wo[win].winhighlight
  vim.wo[win].winhighlight = (wh ~= "" and wh .. "," or "") .. "Folded:CommentFold"

  for _, r in ipairs(ranges) do
    -- A fold spanning exactly 1 line can never close (Vim treats it as
    -- always-open, since collapsing 1 line into 1 line saves nothing), so
    -- skip isolated single-line comments rather than create a dead fold.
    if r[2] > r[1] then
      vim.cmd(string.format("%d,%dfold", r[1] + 1, r[2] + 1))
    end
  end
end

return M
