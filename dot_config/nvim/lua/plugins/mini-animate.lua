-- TODO - make it so the maximum duration of a scroll animation is 200ms (default is 250ms) and make it shorter based on lines to scroll.
return {
  "echasnovski/mini.animate",
  event = "VeryLazy",
  opts = function()
    local animate = require("mini.animate")
    return {
      cursor = { enable = false },
      scroll = {
        enable = true,
        timing = animate.gen_timing.linear { duration = 10, unit = "step" },
        subscroll = animate.gen_subscroll.equal {
          predicate = function(total_scroll)
            return 2 < total_scroll and total_scroll < 250
          end,
          max_output_steps = 60,
        },
      },
      resize = { enable = true },
      open = { enable = true },
      close = { enable = true },
    }
  end,
  config = function(_, opts)
    require("mini.animate").setup(opts)

    local redraw_at_center_after = function(lhs)
      local rhs = function()
        local ok, err = pcall(vim.cmd, "normal!" .. lhs)
        if not ok then
          local E486 = string.find(err, "E486")
          vim.api.nvim_err_writeln(string.sub(err, E486))
        else
          MiniAnimate.execute_after("scroll", "normal! zvzz")
        end
      end
      vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true })
    end

    -- Show pattern matches in the middle of the screen.
    redraw_at_center_after("n")
    redraw_at_center_after("N")
    redraw_at_center_after("*")
    redraw_at_center_after("#")
    redraw_at_center_after("g*")
    redraw_at_center_after("g#")
  end,
}
