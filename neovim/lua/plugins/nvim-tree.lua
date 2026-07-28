return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    ---@type nvim_tree.config
    config = function()
      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end

        -- default mappings
        api.map.on_attach.default(bufnr)

        -- custom mappings

        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        -- space behaves like enter
        vim.keymap.set("n", "<space>", api.node.open.edit, opts("Open"))
      end

      local config = {
        view = {
          width = 50,
        },
        filters = {
          -- true *hides*
          dotfiles = false,
        },
        on_attach = my_on_attach,
      }
      require("nvim-tree").setup(config)
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
    end,
  },
}
