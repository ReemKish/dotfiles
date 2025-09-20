local M = {}
local cmp = require('util.cmp')
local edit = require('util.edit')
local icons = require('util.icons')
local lsp = require('util.lsp')
local lualine = require('util.lualine')
local path = require('util.path')
local statusline = require('util.statusline')

M = {
  cmp = cmp,
  edit = edit,
  icons = icons,
  lsp = lsp,
  lualine = lualine,
  path = path,
  statusline = statusline,
}

return M
