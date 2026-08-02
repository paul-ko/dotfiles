vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_add_keymaps", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end
    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  end,
  desc = "LSP: configure basic keymaps",
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == "ruff" then
      -- Suggested in https://docs.astral.sh/ruff/editors/setup/#neovim
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Ruff (to make way for pyright's)",
})

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("persistence_close_explorer_before_save", { clear = true }),
  pattern = "PersistenceSavePre",
  callback = function()
    -- The snacks explorer is a real window with a non-file buffer; if it's
    -- open when a session is saved, mksession captures it as a window it
    -- can't actually restore, leaving a blank window on the next load.
    local pickers = Snacks.picker.get()
    if #pickers == 0 then
      return
    end
    local wins = {}
    for _, picker in ipairs(pickers) do
      for _, w in ipairs({ picker.input.win.win, picker.list.win.win, picker.preview.win.win }) do
        if w then
          table.insert(wins, w)
        end
      end
      picker:close()
    end
    -- Picker:close() defers its actual window teardown to vim.schedule(), so
    -- without pumping the event loop here, mks! (called right after this
    -- autocmd returns) would still see the picker's windows as open. Check
    -- actual window validity, not Snacks.picker.get() - close() clears its
    -- active-picker bookkeeping synchronously, before the windows go away.
    vim.wait(200, function()
      for _, w in ipairs(wins) do
        if vim.api.nvim_win_is_valid(w) then
          return false
        end
      end
      return true
    end, 10)
  end,
  desc = "Persistence: close snacks explorer before saving session",
})

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("persistence_cleanup_scratch_buffers", { clear = true }),
  pattern = "PersistenceLoadPost",
  callback = function()
    -- A session's blank-window slots get a fresh `enew` scratch buffer on
    -- every load. Vim's own session-load cleanup only wipes the one buffer
    -- that was current *before* sourcing, so loading more than once per
    -- nvim run (e.g. re-triggering a session keymap) leaves prior loads'
    -- scratch buffers behind, still buffer-listed, forever.
    for _, b in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_get_name(b) == "" and not vim.bo[b].modified and #vim.fn.win_findbuf(b) == 0 then
        vim.api.nvim_buf_delete(b, {})
      end
    end
  end,
  desc = "Persistence: wipe orphaned blank buffers left behind by repeated session loads",
})
