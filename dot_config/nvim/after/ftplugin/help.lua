vim.cmd([[setlocal nofoldenable]])

-- Enable 'mini.clue' triggers in help buffer
if _G.MiniClue ~= nil then
  MiniClue.enable_buf_triggers(vim.api.nvim_get_current_buf())
end

vim.b.miniindentscope_disable = true
vim.cmd [[wincmd L]]
