return {
  "echasnovski/mini.files",
  keys = {
    { '<LEADER>ec', '<CMD>lua MiniFiles.open(vim.fn.stdpath("config"))<CR>',     desc = 'Config' },
    { '<LEADER>ed', '<Cmd>lua MiniFiles.open()<CR>',                             desc = 'Directory' },
    { '<LEADER>ef', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', desc = 'File directory' },
  },
  opts = {
    windows = {
      preview = true,
      width_preview = 60,
    },
  },
}
