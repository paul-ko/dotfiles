-- https://cmp.saghen.dev/configuration/general.html
return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },

    version = "1.*", -- Pin major version as of setup.
    opts = {
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = "super-tab" },

      appearance = {
        nerd_font_variant = "mono",
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      sources = {
        default = function()
          local cursor = vim.api.nvim_win_get_cursor(0)
          local row, col = cursor[1] - 1, cursor[2]
          if vim.api.nvim_get_mode().mode == "i" then
            col = math.max(col - 1, 0)
          end
          local node = vim.treesitter.get_node({ pos = { row, col } })

          if
            node and vim.tbl_contains({ "comment", "line_comment", "block_comment", "comment_content" }, node:type())
          then
            return {}
          end
          return { "lsp", "path", "snippets", "buffer" }
        end,
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
