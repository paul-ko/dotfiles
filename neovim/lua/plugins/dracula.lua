-- https://github.com/maxmx03/dracula.nvim/blob/master/README.md
return {
  {
    "maxmx03/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      ---@type dracula
      local dracula = require("dracula")

      dracula.setup({
        styles = {
          Type = {},
          Function = {},
          Parameter = {},
          Property = {},
          Comment = {},
          String = {},
          Keyword = {},
          Identifier = {},
          Constant = {},
        },
        transparent = false,
        -- selene: allow(unused_variable)
        -- on_colors = function(colors, color)
        --   ---@type dracula.palette
        --   return {
        --     -- override or create new colors
        --     -- mycolor = 0xffffff,
        --   }
        -- end,
        -- -- selene: allow(unused_variable)
        -- on_highlights = function(colors, color)
        --   ---@type dracula.highlights
        --   return {
        --     ---@type vim.api.keyset.highlight
        --     -- Normal = { fg = colors.mycolor },
        --   }
        -- end,
        plugins = {
          ["bufferline.nvim"] = true,
          ["gitsigns.nvim"] = true,
          ["indent-blankline.nvim"] = true,
          ["lazy.nvim"] = true,
          ["nvim-lspconfig"] = true,
          ["nvim-tree.lua"] = true,
          ["nvim-treesitter"] = true,
        },
      })
      vim.cmd.colorscheme("dracula")
    end,
  },
  {
    -- https://github.com/nvim-lualine/lualine.nvim
    "nvim-lualine/lualine.nvim",
    opts = function()
      return {
        options = {
          ignore_focus = { "NvimTree" },
          theme = vim.g.colors_name,
          refresh = {
            statusline = 1000,
          },
        },
      }
    end,
  },
}
