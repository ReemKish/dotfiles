return {
  "vimpostor/vim-tpipeline",
  config = function()
    local update_statusline = vim.schedule_wrap(function(data)
      vim.fn["tpipeline#update"]()
    end)
    local gr = vim.api.nvim_create_augroup("MiniStatusline", { clear = false })

    vim.api.nvim_create_autocmd("RecordingEnter", { callback = update_statusline, group = gr })
    vim.api.nvim_create_autocmd("RecordingLeave", { callback = update_statusline, group = gr })
    vim.api.nvim_create_autocmd("DiagnosticChanged", { callback = update_statusline, group = gr })
    vim.g.tpipeline_autoembed = 0
  end,
  dependencies = {
    -- Important: Make mini.statusline load before tpipeline.
    "echasnovski/mini.statusline",
  },
}
