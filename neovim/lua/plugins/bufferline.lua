-- https://github.com/akinsho/bufferline.nvim
-- :h bufferline-configuration
return {
  {
    "akinsho/bufferline.nvim",
    version = "4.*", -- Pin major version as of setup
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          numbers = "buffer_id",
          diagnostics = "nvim_lsp", -- Causes the buffer's name to change color if it has errors or warns
          offsets = {
            {
              -- snacks explorer's sidebar (replaced nvim-tree). Its visible
              -- input/list panes are floating windows, not real splits, so
              -- bufferline can't see them; `snacks_layout_box` is the actual
              -- split window occupying that screen region, confirmed via
              -- bufferline.offset's own window-layout inspection.
              filetype = "snacks_layout_box",
              text = "File explorer",
              highlight = "Directory",
              separator = true,
            },
          },
        },
      })
      vim.keymap.set("n", "gb", "<cmd>BufferLinePick<cr>", { desc = "Trigger bufferline tab picker" })
    end,
  },
}
