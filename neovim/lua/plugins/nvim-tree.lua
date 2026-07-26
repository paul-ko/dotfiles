return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        ---@type nvim_tree.config
        config = function()
            local config = {
                view = {
                    width = 50
                },
                filters = {
                    -- true *hides*
                    dotfiles = true
                }
            }
            require("nvim-tree").setup(config)
            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
        end
    }
}
