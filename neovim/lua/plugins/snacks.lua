local groups = require("keymap_groups")
local file_categories = require("file_categories")

local explorer_hide_globs = { ".git", "__*__", ".venv", "uv.lock" }
local code_exclude_globs = file_categories.code_exclude_globs()

--[[
Builds the `,f` / `,s` / `,w` category matrix: each of find/search/word gets one
leaf per file category (config/docs/structured/other), plus `c` (code, everything
that isn't a known category) and `a` (all, unfiltered).
]]
local function matrix_keys()
  local keys = {}

  local function code_files()
    return Snacks.picker.files({ frecency = true, exclude = code_exclude_globs })
  end
  local function all_files()
    return Snacks.picker.files({ frecency = true })
  end
  local function code_grep()
    return Snacks.picker.grep({ exclude = code_exclude_globs })
  end
  local function all_grep()
    return Snacks.picker.grep()
  end
  local function code_word()
    return Snacks.picker.grep_word({ args = { "--word-regexp" }, exclude = code_exclude_globs })
  end
  local function all_word()
    return Snacks.picker.grep_word()
  end

  local groups_spec = {
    {
      prefix = groups.find,
      label = "find files",
      all = all_files,
      code = code_files,
      category = function(category)
        if not file_categories.any_files(category.globs) then
          vim.notify("No " .. category.label .. " files found", vim.log.levels.INFO)
          return
        end
        return Snacks.picker.files({
          frecency = true,
          cmd = "rg",
          args = file_categories.include_args(category.globs),
        })
      end,
    },
    {
      prefix = groups.search,
      label = "grep",
      all = all_grep,
      code = code_grep,
      category = function(category)
        return Snacks.picker.grep({ args = file_categories.include_args(category.globs) })
      end,
    },
    {
      prefix = groups.word,
      label = "word",
      all = all_word,
      code = code_word,
      category = function(category)
        local args = { "--word-regexp" }
        vim.list_extend(args, file_categories.include_args(category.globs))
        return Snacks.picker.grep_word({ args = args })
      end,
    },
  }

  for _, spec in ipairs(groups_spec) do
    table.insert(keys, { spec.prefix .. "a", spec.all, desc = spec.label .. ": all" })
    table.insert(keys, { spec.prefix .. "c", spec.code, desc = spec.label .. ": code" })
    for _, category in ipairs(file_categories.categories) do
      table.insert(keys, {
        spec.prefix .. category.letter,
        function()
          return spec.category(category)
        end,
        desc = spec.label .. ": " .. category.label,
      })
    end
  end

  return keys
end

local static_keys = {
  -- Memory keymaps - what I use most frequently.
  {
    groups.memory .. "f",
    function()
      Snacks.picker.files({ frecency = true, exclude = code_exclude_globs })
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
    groups.find .. "e",
    function()
      Snacks.picker.explorer()
    end,
    desc = "snacks explorer",
  },

  -- Git
  {
    groups.git .. "l",
    function()
      Snacks.picker.git_log()
    end,
    desc = "git log",
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
}

local plugin_keys = {}
vim.list_extend(plugin_keys, static_keys)
vim.list_extend(plugin_keys, matrix_keys())

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
    keys = plugin_keys,
  },
}
