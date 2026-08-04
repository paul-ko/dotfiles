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

local explorer_hide_globs = { ".git", "__*__", ".venv", "uv.lock" }

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
          files = { hidden = true },
          grep = { hidden = true },
          grep_word = { hidden = true },
          -- `hidden` lives on snacks.picker.explorer.Config (inherited from
          -- snacks.picker.files.Config), not on the top-level `explorer`
          -- table below (snacks.explorer.Config) - separate config surfaces.
          explorer = {
            -- Disable diagnostics display, since it is misleading in the picker, showing them for files that do not
            -- have valid diagnostic findings.  I suspect it may be reflecting the rough first-pass treesitter
            -- diagnostics that display briefly when a buffer is opened, but not the improved lsp diagnostics that those
            -- are overwritten by in the buffer.  Either way, they're misleading, and even if they were functional I
            -- don't know if I would want them to display.
            diagnostics = false,
            hidden = true,
            ignored = true,
            exclude = explorer_hide_globs,
          },
        },
      },
      explorer = {
        hidden = true,
        ignored = true,
        exclude = explorer_hide_globs,
      },
    },
    keys = {
      -- Memory keymaps - what I use most frequently.
      {
        groups.memory .. "f",
        function()
          Snacks.picker.files({ frecency = true, hidden = true, exclude = non_code_files_glob })
        end,
        desc = "Search code files",
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
        groups.buffers .. "l",
        function()
          Snacks.picker.buffers()
        end,
        desc = "list all buffers",
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

      -- Help / reference (no group yet; see fuzzy-future.md)
      {
        "<leader>K",
        function()
          Snacks.win({
            file = vim.fn.stdpath("config") .. "/docs/keystrokes.md",
            ft = "markdown",
            width = 0.6,
            height = 0.6,
            wo = { wrap = true },
          })
        end,
        desc = "Show keystrokes cheat sheet",
      },
    },
  },
}
