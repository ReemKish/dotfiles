return {
  "echasnovski/mini.diff",
  opts = function()
    local icons = require("util.icons")
    return {
      view = {
        style = "sign",
        signs = {
          add = icons.ui.BoldLineMiddle,
          change = icons.ui.BoldLineDashedMiddle,
          delete = icons.ui.TriangleShortArrowRight,
        },
        priority = 50,
      },
    }
  end,
  dependencies = { "folke/snacks.nvim" },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        Snacks.toggle({
          name = "Diff Overlay",
          get = function() return (MiniDiff.get_buf_data() or {}).overlay end,
          set = function(state)
            MiniDiff.toggle_overlay()
          end,
        }):map("<leader>uo")
      end
    })
  end,
}
