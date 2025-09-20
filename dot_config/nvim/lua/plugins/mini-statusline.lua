return {
  "echasnovski/mini.statusline",
  version = "*",
  opts = function()
    local TRUNCATE = math.huge
    -- stylua: ignore start
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormalAlt',  {fg = vim.api.nvim_get_hl(0, {name = "MiniStatuslineModeNormal"}).bg})
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeInsertAlt',  {fg = vim.api.nvim_get_hl(0, {name = "MiniStatuslineModeInsert"}).bg})
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeVisualAlt',  {fg = vim.api.nvim_get_hl(0, {name = "MiniStatuslineModeVisual"}).bg})
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeReplaceAlt', {fg = vim.api.nvim_get_hl(0, {name = "MiniStatuslineModeReplace"}).bg})
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeCommandAlt', {fg = vim.api.nvim_get_hl(0, {name = "MiniStatuslineModeCommand"}).bg})
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeOtherAlt',   {fg = vim.api.nvim_get_hl(0, {name = "MiniStatuslineModeOther"}).bg})
    -- stylua: ignore end

    return {
      content = {
        active = function()

          -- stylua: ignore start
          local mode, mode_hl   = MiniStatusline.section_mode({ trunc_width = TRUNCATE })
          local git             = MiniStatusline.section_git({ trunc_width = 40, icon = '' })
          local diagnostics     = Util.statusline.section_diagnostics(MiniStatusline.section_diagnostics({ icon = "" }))
          local icon, icon_hl   = Util.statusline.section_icon()
          local fname, fname_hl = Util.statusline.section_filename()
          local diff            = Util.statusline.section_diff(MiniStatusline.section_diff({ icon = "" }))
          local recording       = Util.statusline.section_recording()
          local fileinfo        = MiniStatusline.section_fileinfo({ trunc_width = TRUNCATE })
          local location        = MiniStatusline.section_location({ trunc_width = TRUNCATE })
          local search          = MiniStatusline.section_searchcount({ trunc_width = 0 })
          -- stylua: ignore end

          local mode_alt_hl = mode_hl .. "Alt"

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = mode_alt_hl, strings = { git } },
            { hl = icon_hl, strings = { icon } },
            { hl = fname_hl, strings = { fname } },
            diagnostics,
            "%=", -- End left alignment
            { hl = "MatchParen", strings = { recording } },
            diff,
            { hl = mode_alt_hl, strings = { fileinfo } },
            { strings = { search, location } },
          })
        end,
      },
    }
  end,
}
