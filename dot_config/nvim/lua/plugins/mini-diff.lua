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
}
