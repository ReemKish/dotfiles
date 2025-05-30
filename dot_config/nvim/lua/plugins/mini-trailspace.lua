return {
  'echasnovski/mini.trailspace',
  event = { "InsertEnter" },
  opts = {},
  dependencies = { "folke/snacks.nvim" },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        Snacks.toggle({
          name = "Trailspace",
          get = function() return not vim.g.minitrailspace_disable end,
          set = function(state)
            vim.g.minitrailspace_disable = not state
            if state then MiniTrailspace.highlight() else MiniTrailspace.unhighlight() end
          end,
        }):map("<leader>ut")
      end
    })
  end
}
