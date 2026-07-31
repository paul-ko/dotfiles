-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    config = function()
      local parsers = { "python", "lua", "vim", "json", "yaml", "toml" }
      -- Patterns that the active filename is checked against; if it matches one of these, nvim-treesitter will start.
      -- This is currently set to `parsers` because for all currently supported parsers, the file extension matches the
      -- parser name.  There is no guarantee this will remain true; some parsers' names don't match the typical file
      -- extensions we'd want them active for.  When/if such a parser is added here, these variables will need to be set
      -- to separate tables with separate values.
      --
      -- It's not clear to me from the neovim docs why the patterns only need to match partially, without `*`, but this
      -- does work, and is consistent with nvim-treesitter's README.
      local file_types = parsers
      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("start nvim-treesitter", { clear = true }),
        pattern = file_types,
        callback = function()
          vim.treesitter.start()
        end,
      })

      -- Custom command to print the selected node's type, based on logic used in blink.lua.
      vim.api.nvim_create_user_command("TSNodeType", function()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local row, col = cursor[1] - 1, cursor[2]
        if vim.api.nvim_get_mode().mode == "i" then
          col = math.max(col - 1, 0)
        end
        local node = vim.treesitter.get_node({ pos = { row, col } })
        if node then
          print(node:type())
        else
          print("Not in node")
        end
      end, { nargs = 0 })
    end,
  },
}
