return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        -- nvim-lspconfig's own settings types (e.g. lspconfig.settings.pyright),
        -- used in config/lsp.lua. Not covered by the `lspconfig` integration below,
        -- which only fixes vim.lsp.config workspace/root_dir handling.
        -- Built from lazy's install path directly (not vim.api.nvim_get_runtime_file):
        -- this opts table is evaluated while lazy.nvim is still collecting specs,
        -- before nvim-lspconfig is actually on the runtimepath.
        { path = vim.fn.stdpath("data") .. "/lazy/nvim-lspconfig/lua/lspconfig", words = { "lspconfig" } },
      },
    },
  },
}
