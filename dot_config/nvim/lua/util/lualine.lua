local M = {}

-- Mode -----------------------------------------------------------------------
-- Taken from https://github.com/echasnovski/mini.statusline/blob/main/lua/mini/statusline.lua
-- Custom `^V` and `^S` symbols to make this file appropriate for copy-paste
-- (otherwise those symbols are not displayed).
local CTRL_S = vim.api.nvim_replace_termcodes("<C-S>", true, true, true)
local CTRL_V = vim.api.nvim_replace_termcodes("<C-V>", true, true, true)

-- stylua: ignore start
M.modes = setmetatable({
  ['n']    = { long = 'Normal',   short = 'N'   },
  ['v']    = { long = 'Visual',   short = 'V'   },
  ['V']    = { long = 'V-Line',   short = 'V-L' },
  [CTRL_V] = { long = 'V-Block',  short = 'V-B' },
  ['s']    = { long = 'Select',   short = 'S'   },
  ['S']    = { long = 'S-Line',   short = 'S-L' },
  [CTRL_S] = { long = 'S-Block',  short = 'S-B' },
  ['i']    = { long = 'Insert',   short = 'I'   },
  ['R']    = { long = 'Replace',  short = 'R'   },
  ['c']    = { long = 'Command',  short = 'C'   },
  ['r']    = { long = 'Prompt',   short = 'P'   },
  ['!']    = { long = 'Shell',    short = 'Sh'  },
  ['t']    = { long = 'Terminal', short = 'T'   },
}, {
  __index = function()
    return   { long = 'Unknown',  short = 'U',   hl = '%#MiniStatuslineModeOther#' }
  end,
})
-- stylua: ignore end

---@param component any
---@param text string
---@param hl_group? string
---@return string
function M.format(component, text, hl_group)
  text = text:gsub("%%", "%%%%")
  if not hl_group or hl_group == "" then
    return text
  end
  ---@type table<string, string>
  component.hl_cache = component.hl_cache or {}
  local lualine_hl_group = component.hl_cache[hl_group]
  if not lualine_hl_group then
    local utils = require("lualine.utils.utils")
    ---@type string[]
    local gui = vim.tbl_filter(function(x)
      return x
    end, {
      utils.extract_highlight_colors(hl_group, "bold") and "bold",
      utils.extract_highlight_colors(hl_group, "italic") and "italic",
    })

    lualine_hl_group = component:create_hl({
      fg = utils.extract_highlight_colors(hl_group, "fg"),
      gui = #gui > 0 and table.concat(gui, ",") or nil,
    }, "LV_" .. hl_group) --[[@as string]]
    component.hl_cache[hl_group] = lualine_hl_group
  end
  return component:format_hl(lualine_hl_group) .. text .. component:get_default_hl()
end

---@param opts? {modified_hl: string?, directory_hl: string?, filename_hl: string?, modified_sign: string?, readonly_icon: string?, length: number?}
function M.pretty_path(opts)
  opts = vim.tbl_extend("force", {
    modified_hl = "MatchParen",
    directory_hl = "LspCodeLens",
    filename_hl = "Bold",
    modified_sign = "",
    readonly_icon = " 󰌾 ",
    length = 3,
  }, opts or {})

  return function(self)
    local path = vim.fn.expand("%:p") --[[@as string]]

    if path == "" then
      return ""
    end

    path = Util.path.norm(path)
    local cwd = Util.path.cwd()

    if path:find(cwd, 1, true) == 1 then
      path = path:sub(#cwd + 2)
    end

    local parts = vim.split(path, "/")

    if opts.length == 0 then
      parts = parts
    elseif #parts > opts.length then
      parts = { parts[1], "…", unpack(parts, #parts - opts.length + 2, #parts) }
    end

    if opts.modified_hl and vim.bo.modified then
      parts[#parts] = parts[#parts] .. opts.modified_sign
      parts[#parts] = M.format(self, parts[#parts], opts.modified_hl)
    else
      parts[#parts] = M.format(self, parts[#parts], opts.filename_hl)
    end

    local dir = ""
    if #parts > 1 then
      dir = table.concat({ unpack(parts, 1, #parts - 1) }, "/")
      dir = M.format(self, dir .. "/", opts.directory_hl)
    end

    local readonly = ""
    if vim.bo.readonly then
      readonly = M.format(self, opts.readonly_icon, opts.modified_hl)
    end
    return dir .. parts[#parts] .. readonly
  end
end

---@param opts? {format?: "short" | "long"}
function M.mode(opts)
  opts = vim.tbl_extend("force", {
    format = "short",
  }, opts or {})

  return function(self)
    return M.modes[vim.api.nvim_get_mode().mode][opts.format]
  end
end

return M
