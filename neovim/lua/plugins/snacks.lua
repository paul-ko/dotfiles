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
        groups.find .. "d",
        function()
          -- No built-in snacks "directories" source; fd is preferred (matches
          -- snacks' own internal directory listing) but not required.
          -- (Not using snacks.picker.source.files.get_fd() here: it's an
          -- "assert fd is required" helper, not a quiet availability check -
          -- it notifies an error as a side effect whenever fd is missing,
          -- even though we have a working fallback.)
          local fd = vim.fn.executable("fd") == 1 and "fd" or (vim.fn.executable("fdfind") == 1 and "fdfind" or nil)
          local cmd = fd or "find"
          local args = fd and { "--type", "d", "--color", "never", "-E", ".git" }
            or { ".", "-type", "d", "-not", "-path", "*/.git*" }
          Snacks.picker.pick({
            -- proc() needs a real ctx (supplied when the picker calls this),
            -- not one built at config-construction time.
            finder = function(_, ctx)
              return require("snacks.picker.source.proc").proc({
                cmd = cmd,
                args = args,
                transform = function(item)
                  item.file = item.text
                end,
              }, ctx)
            end,
            format = "file",
            confirm = function(picker, item)
              picker:close()
              if item then
                require("nvim-tree.api").tree.find_file({ buf = item.file, open = true, focus = true })
              end
            end,
          })
        end,
        desc = "find directory, reveal in tree",
      },
      {
        -- TRIAL: comparing against nvim-tree; if this covers day-to-day use,
        -- retire nvim-tree.lua and the "find directory, reveal in tree"
        -- keymap above in favor of this.
        -- Uppercase specifically to avoid colliding with nvim-tree.lua's own
        -- `,fe`/`,,e` (NvimTreeToggle) - see keymap collision investigation.
        groups.find .. "E",
        function()
          Snacks.picker.explorer()
        end,
        desc = "[trial] snacks explorer",
      },
      {
        -- TRIAL: dirs-only equivalent of the nvim-tree "find directory,
        -- reveal in tree" keymap above, for the snacks explorer instead.
        groups.find .. "D",
        function()
          Snacks.picker.explorer({
            transform = function(item)
              return item.dir == true
            end,
          })
        end,
        desc = "[trial] snacks explorer, directories only",
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
