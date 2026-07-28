return {
  {
    "akinsho/bufferline.nvim",
    version = "4.*", -- Pin major version as of setup
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          numbers = { "buffer_id" },
        },
      })
    end,
  },
}
