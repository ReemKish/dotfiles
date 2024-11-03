return {
  "echasnovski/mini.statusline",
  opts = function()
    local a = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git = MiniStatusline.section_git({ trunc_width = 40 })
      local diff = MiniStatusline.section_diff({ trunc_width = 75 })
      local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local filename = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location = MiniStatusline.section_location({ trunc_width = 75 })
      local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

      return MiniStatusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        -- { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
        { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=", -- End left alignment
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        { hl = mode_hl, strings = { location } },
      })
    end
    return {
      -- Content of statusline as functions which return statusline string. See
      -- `:h statusline` and code of default contents (used instead of `nil`).
      content = {
        active = a,
        inactive = nil,
      },

      -- Whether to use icons by default
      use_icons = true,

      -- Whether to set Vim's settings for statusline (make it always shown)
      set_vim_settings = true,
    }
  end,
}
