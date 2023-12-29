local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader to space.
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- <C-Space> opens WhichKey immediately.
keymap("n", "<C-Space>", "<cmd>WhichKey \\<space><cr>", opts)
keymap("n", "<C-i>", "<C-i>", opts)

-- Better window navigation, with tmux interoperation.
keymap("n", "<C-h>", ":NavigatorLeft<CR>", opts)
keymap("n", "<C-j>", ":NavigatorDown<CR>", opts)
keymap("n", "<C-k>", ":NavigatorUp<CR>", opts)
keymap("n", "<C-l>", ":NavigatorRight<CR>", opts)
keymap("n", "<C-tab>", ":NavigatorPrevious<CR>", opts)

keymap({"n", "i"}, "<C-s>", "<ESC>:w<CR>", opts)  -- save
keymap({"n", "i"}, "<C-q>", "<ESC>:q<CR>", opts)  -- quit

keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Stay in indent mode when readjusting indentation.
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- jk to exit insert mode
keymap("i", "jk", "<ESC>")

keymap("x", "p", [["_dP]])

vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]

vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")
