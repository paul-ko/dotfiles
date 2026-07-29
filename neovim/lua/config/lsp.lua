-- LSP setup

vim.diagnostic.config({
  float = {
    -- border need for legibility
    border = "rounded",
  },
  jump = {
    -- Open diagnostics in floating window on jump
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({
        bufnr = bufnr,
        scope = "cursor",
        focus = false,
      })
    end,
  },
})

------------
-- Python --
------------

-- pyright
vim.lsp.config("pyright", {
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        -- They provide non-overlapping feedback so I think it's best to have them both ignore = { '*' },
      },
    },
  },
})
vim.lsp.enable({ "pyright" })

-- https://docs.astral.sh/ruff/editors/setup/#neovim
vim.lsp.config("ruff", {
  init_options = {
    settings = {
      logLevel = "info", -- This is default; including to have a working stub
    },
  },
})
vim.lsp.enable("ruff")

----------
-- bash --
----------

vim.lsp.config("bashls", {})
vim.lsp.enable("bashls")
