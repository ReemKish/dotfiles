-- Show line after desired maximum text width
vim.opt_local.textwidth = 89
vim.opt_local.colorcolumn = "+1"
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
-- vim.opt_local.foldmethod = "indent"

-- Indentation
vim.g.pyindent_open_paren = "shiftwidth()"
vim.g.pyindent_continue = "shiftwidth()"

-- mini.indentscope
vim.b.miniindentscope_config = { options = { border = "top" } }

vim.api.nvim_buf_set_var(0, "disabled_codeactions", {
  "Ruff: Fix all auto--fixable problems",
  "Ruff: Organize imports",
})

vim.api.nvim_buf_set_var(0, "lightbulb_ignore_codeactions", {
  "Ruff: Fix all auto--fixable problems",
  "Ruff: Organize imports",
  "Disable for this line",
})
