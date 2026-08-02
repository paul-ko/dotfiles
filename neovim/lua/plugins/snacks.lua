local groups = require("keymap_groups")
local utils = require("utils")

--[[
File (extension) globs used to pre-filter pickers.  These are based on codebases that this config is active in, and will
need to be updated over time.
]]
local config_files_glob = { "*.*config", "*.ini" }
local doc_files_glob = { "*.md", "*.txt" }
local structured_files_glob = { "*.csv", "*.json", "*.toml", "*.yaml" }
local other_non_code = { "LICENSE", "*.lock" }
local non_code_files_glob =
  utils.combine_lists(doc_files_glob, structured_files_glob, config_files_glob, other_non_code)

return {
  {
    "folke/snacks.nvim",
    -- Needs to be active from startup, not just on first keypress: the
    -- explorer's netrw-replacement hook (its BufEnter autocmd, registered
    -- inside the plugin's own code) has to exist before `nv <dir>` opens
    -- its directory buffer, or there's nothing to catch that first buffer.
    lazy = false,
    ---@type snacks.Config
    opts = {
      picker = {
        sources = {
          -- `hidden` lives on snacks.picker.explorer.Config (inherited from
          -- snacks.picker.files.Config), not on the top-level `explorer`
          -- table below (snacks.explorer.Config) - separate config surfaces.
          explorer = {
            hidden = true,
          },
        },
      },
      explorer = {},
    },
    keys = {
      -- Memory keymaps - what I use most frequently.
      {
        groups.memory .. "f",
        function()
          Snacks.picker.files({ frecency = true, hidden = true })
        end,
        desc = "Search files all",
      },
      {
        groups.memory .. "g",
        function()
          Snacks.picker.grep()
        end,
        desc = "Live grep",
      },
      {
        groups.memory .. "e",
        function()
          Snacks.picker.explorer()
        end,
        desc = "Explorer",
      },

      -- Buffers
      {
        groups.buffers .. "a",
        function()
          Snacks.picker.buffers()
        end,
        desc = "view all buffers",
      },
      {
        groups.buffers .. "d",
        function()
          Snacks.picker.buffers({ modified = true })
        end,
        desc = "view dirty buffers",
      },

      -- Find files/directories
      {
        groups.find .. "a",
        function()
          Snacks.picker.files({ frecency = true })
        end,
        desc = "find files all",
      },
      {
        groups.find .. "c",
        function()
          Snacks.picker.files({ frecency = true, exclude = non_code_files_glob })
        end,
        desc = "find files code",
      },
      {
        groups.find .. "e",
        function()
          Snacks.picker.explorer()
        end,
        desc = "snacks explorer",
      },
      {
        groups.find .. "d",
        function()
          Snacks.picker.explorer({
            transform = function(item)
              return item.dir == true
            end,
          })
        end,
        desc = "snacks explorer, directories only",
      },

      -- Git
      {
        groups.git .. "l",
        function()
          Snacks.picker.git_log()
        end,
        desc = "git log",
      },
      {
        groups.git .. "d",
        function()
          Snacks.picker.git_diff()
        end,
        desc = "git diff",
      },

      -- Search (content)
      {
        groups.search .. "a",
        function()
          Snacks.picker.grep()
        end,
        desc = "search content all",
      },
      {
        groups.search .. "c",
        function()
          Snacks.picker.grep({ exclude = non_code_files_glob })
        end,
        desc = "search content code",
      },

      -- Word (cursor-based)
      {
        groups.search .. "w",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "grep current word within project",
      },
    },
  },
}
