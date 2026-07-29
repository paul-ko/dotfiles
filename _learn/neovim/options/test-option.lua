-- Usage: nvim --clean -l test-option.lua <setter> <option> <value> <check_cmd>
local setter, opt_name, value_str, check_cmd = arg[1], arg[2], arg[3], arg[4]

local value
if value_str == "true" then
  value = true
elseif value_str == "false" then
  value = false
elseif tonumber(value_str) then
  value = tonumber(value_str)
else
  value = value_str
end

local function get(scope)
  local ok, v = pcall(vim.api.nvim_get_option_value, opt_name, scope and { scope = scope } or {})
  return ok and tostring(v) or "ERROR"
end

local function scope_label(name)
  local ok, info = pcall(vim.api.nvim_get_option_info2, name, {})
  if not ok then
    return "UNKNOWN"
  end
  local base = ({ global = "global", win = "local to window", buf = "local to buffer" })[info.scope] or info.scope
  if info.global_local and base ~= "global" then
    return "global or " .. base
  end
  return base
end

local function csv_field(s)
  s = tostring(s)
  if s:find('[,"\n]') then
    s = '"' .. s:gsub('"', '""') .. '"'
  end
  return s
end

local function row(fields)
  print(table.concat(vim.tbl_map(csv_field, fields), ","))
end

local scope = scope_label(opt_name)
local global_before = get("global")

local ok, err = pcall(function()
  if setter == "wo" then
    vim.wo[opt_name] = value
  elseif setter == "bo" then
    vim.bo[opt_name] = value
  elseif setter == "o" then
    vim.o[opt_name] = value
  elseif setter == "opt_local" then
    vim.opt_local[opt_name] = value
  elseif setter == "go" then
    vim.go[opt_name] = value
  else
    error("unknown setter: " .. setter)
  end
end)

if not ok then
  row({ scope, setter, opt_name, tostring(value), check_cmd, global_before, "N/A", "N/A", "error", tostring(err) })
  return
end

local global_after = get("global")
vim.cmd(check_cmd)
row({ scope, setter, opt_name, tostring(value), check_cmd, global_before, global_after, get(nil), "ok", "" })
