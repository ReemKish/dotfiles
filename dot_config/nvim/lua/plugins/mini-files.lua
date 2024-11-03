return {
  "echasnovski/mini.files",
  keys = {
    { '<LEADER>e',  '',                                                          desc = '+Explore' },
    { '<LEADER>ec', '<CMD>lua MiniFiles.open(vim.fn.stdpath("config"))<CR>',     desc = 'Config' },
    { '<LEADER>ed', '<Cmd>lua MiniFiles.open()<CR>',                             desc = 'Directory' },
    { '<LEADER>ef', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', desc = 'File directory' },
    { '<LEADER>eq', '<Cmd>lua Config.toggle_quickfix()<CR>',                     desc = 'Quickfix' },
  },
  opts = {
    windows = {
      preview = true,
      width_preview = 60,
    },
  },
  init = function()
    -- Also load mini-files when vim is used to open a directory.
    -- Without this, netrw will be used instead.
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("mini_files_start_directory", { clear = true }),
      desc = "Start MiniFiles with directory",
      once = true,
      callback = function()
        if package.loaded["mini.files"] then
          return
        else
          local stats = vim.uv.fs_stat(vim.fn.argv(0))
          if stats and stats.type == "directory" then
            require("mini.files").open()
          end
        end
      end,
    })
  end,
}
