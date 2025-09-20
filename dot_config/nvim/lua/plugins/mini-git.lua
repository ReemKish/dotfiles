return {
  "echasnovski/mini-git",
  main = "mini.git",
  init = function()
    local format_summary = function(data)
      local summary = vim.b[data.buf].minigit_summary
      vim.b[data.buf].minigit_summary_string = summary.head_name or ""
    end

    local au_opts = { pattern = "MiniGitUpdated", callback = format_summary }
    vim.api.nvim_create_autocmd("User", au_opts)
  end,
  opts = {},
}
