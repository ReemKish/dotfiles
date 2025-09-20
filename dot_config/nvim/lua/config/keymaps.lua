local map = function(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

local unmap = function(mode, lhs)
  vim.keymap.del(mode, lhs)
end


-- Set leader to space.
map("n", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Clear search and stop snippet on escape
map({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  Util.cmp.actions.snippet_stop()
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })


-- Insert comments above/below/at end of line.
map("n", "gcO", function() Util.edit.insert_comment("O") end, { desc = "Add Comment Above"})
map("n", "gco", function() Util.edit.insert_comment("o") end, { desc = "Add Comment Below"})
map("n", "gcA", function() Util.edit.insert_comment("A  ") end, { desc = "Add Comment To Line"})

-- Unmap default LSP keymappings (:h grr)
unmap("n", "grr")
unmap("n", "gra")
unmap("n", "gri")
unmap("n", "grn")

-- Better window navigation, with tmux interoperation.
map("n", "<C-h>", ":NavigatorLeft<CR>")
map("n", "<C-j>", ":NavigatorDown<CR>")
map("n", "<C-k>", ":NavigatorUp<CR>")
map("n", "<C-l>", ":NavigatorRight<CR>")
map("n", "<C-tab>", ":NavigatorPrevious<CR>")

-- Traditional editor keymaps.
map({ "i", "x", "n", "s" }, "<C-s>", "<CMD>confirm write<CR>", { desc = "Save File" })

-- New file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- X shows diagnostics
map("n", "X", vim.diagnostic.open_float)

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Stay in visual mode when readjusting indentation.
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Don't override the yank register when pasting over selected text.
map("x", "p", [["_dP]])

-- Mouse right-click menu
vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

-- Use H and L to go to start of/end of line.
map({ "n", "o", "x" }, "<s-h>", "^")
map({ "n", "o", "x" }, "<s-l>", "g_")

vim.api.nvim_set_keymap("t", "<C-;>", "<C-\\><C-n>", { noremap = true, silent = true })
