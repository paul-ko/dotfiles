--[[
Useful docs:

- Some key configs (opts): https://cmp.saghen.dev/configuration/general.html
- Full configs (opts): https://cmp.saghen.dev/configuration/reference.html
- config recipes: https://cmp.saghen.dev/recipes.html
]]
return {
  {
    "saghen/blink.cmp",

    version = "1.*", -- Pin major version as of setup.
    opts = {
      keymap = {
        -- https://cmp.saghen.dev/configuration/keymap.html
        preset = "super-tab",
        -- ENTER accepts in addition to preset TAB.
        ["<CR>"] = { "accept", "fallback" },
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = { documentation = { auto_show = true } },

      -- Disable by filetype
      enabled = function()
        return not vim.tbl_contains({ "txt", "markdown", "gitcommit" }, vim.bo.filetype)
      end,

      sources = {
        -- Set min_keyword_length to a number to control how many chars must be typed before matches display
        default = function()
          local cursor = vim.api.nvim_win_get_cursor(0)
          local row, col = cursor[1] - 1, cursor[2]
          if vim.api.nvim_get_mode().mode == "i" then
            col = math.max(col - 1, 0)
          end
          local node = vim.treesitter.get_node({ pos = { row, col } })
          local comment_node_types = {
            "comment",
            "line_comment",
            "block_comment",
            "comment_content",
            "string_content", -- python docstrngs are string_content, but this has a wider blast radius
          }

          if node and vim.tbl_contains(comment_node_types, node:type()) then
            return {}
          end
          return { "lsp", "path" }
        end,
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
