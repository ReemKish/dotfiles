local keymap = function(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

local keyunmap = function(mode, lhs)
  vim.keymap.del(mode, lhs)
end

local insert_comment = function(prefix_keys)
  prefix_keys = prefix_keys or ""
  local comment_fmt = vim.api.nvim_get_option_value("commentstring", {})
  local empty_comment = string.format(comment_fmt, "")
  vim.api.nvim_input(prefix_keys .. empty_comment)
end

-- Set leader to space.
keymap("n", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "gcA", function()
  insert_comment("A  ")
end) -- Append comment at the end of the line.
keymap("n", "gco", function()
  insert_comment("o")
end) -- Begin comment in a new line below
keymap("n", "gcO", function()
  insert_comment("O")
end) -- Begin comment in a new line above

-- Unmap default LSP keymappings (:h grr)
keyunmap("n", "grr")
keyunmap("n", "gra")
keyunmap("n", "gri")
keyunmap("n", "grn")

-- Better window navigation, with tmux interoperation.
keymap("n", "<C-h>", ":NavigatorLeft<CR>")
keymap("n", "<C-j>", ":NavigatorDown<CR>")
keymap("n", "<C-k>", ":NavigatorUp<CR>")
keymap("n", "<C-l>", ":NavigatorRight<CR>")
keymap("n", "<C-tab>", ":NavigatorPrevious<CR>")

-- Traditional editor keymaps.
keymap({ "n", "i" }, "<C-s>", "<CMD>confirm write<CR>") -- save
keymap({ "n", "i" }, "<C-q>", "<CMD>confirm quit<CR>") -- quit

-- Show pattern matches in the middle of the screen.
-- keymap("n", "n", "nzvzz")
-- keymap("n", "N", "Nzvzz")
-- keymap("n", "*", "*zvzz")
-- keymap("n", "#", "#zvzz")
-- keymap("n", "g*", "g*zvzz")
-- keymap("n", "g#", "g#zvzz")

keymap("n", "X", vim.diagnostic.open_float)

-- Stay in visual mode when readjusting indentation.
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Don't override the yank register when pasting over selected text.
keymap("x", "p", [["_dP]])

-- Mouse right-click menu
vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

-- Use H and L to go to start of/end of line.
keymap({ "n", "o", "x" }, "<s-h>", "^")
keymap({ "n", "o", "x" }, "<s-l>", "g_")

vim.api.nvim_set_keymap("t", "<C-;>", "<C-\\><C-n>", { noremap = true, silent = true })
