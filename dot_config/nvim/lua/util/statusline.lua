M = {}

M.section_icon = function()
  local ft = vim.bo.filetype
  local icon, icon_hl, _ = MiniIcons.get("filetype", ft)
  return icon, icon_hl
end

M.section_filename = function()
  local ft = vim.bo.filetype
  local filename = vim.fn.expand("%")
  local default = { "%f%{&modified?'':''}%{&readonly?' 󰌾':''}", "MiniStatuslineFilename" }
  local cases = {
    minifiles = {
      (string.match(filename, "//[^/]+/(.+)") or ""):gsub("^" .. vim.env.HOME, "~"),
    },
  }
  local pair = cases[ft] or default
  return pair[1], pair[2] or "MiniStatuslineFilename"
end

M.section_diagnostics = function(diagnostics_text)
  local format = {
    E = "%#DiagnosticError# ",
    W = "%#DiagnosticWarn# ",
    I = "%#DiagnosticInfo# ",
    H = "%#DiagnosticHint# ",
  }
  local diagnostic_parts = {}
  for diag in string.gmatch(diagnostics_text, "(%S%d+)") do
    local diag_type = diag:sub(1, 1)
    local count = diag:sub(2)
    table.insert(diagnostic_parts, format[diag_type] .. count)
  end
  return " " .. table.concat(diagnostic_parts, " ")
end

M.section_diff = function(diff_text)
  local format = {
    ["+"] = "%#diffAdded# ",
    ["-"] = "%#diffDeleted# ",
    ["~"] = "%#diffChanged# ",
  }
  local diff_parts = {}
  for diff in string.gmatch(diff_text, "[~%+%-]%d+") do
    local diff_type = diff:sub(1, 1)
    local count = diff:sub(2)
    table.insert(diff_parts, format[diff_type] .. count)
  end
  return table.concat(diff_parts, " ")
end

M.section_recording = function()
  local rec_reg = vim.fn.reg_recording()
  return rec_reg ~= "" and ("%#Error# %#MatchParen#recording @" .. rec_reg) or ""
end

return M
