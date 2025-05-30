M = {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = function()
    Util.cmp.actions.snippet_forward = function()
      if require("luasnip").jumpable(1) then
        vim.schedule(function()
          require("luasnip").jump(1)
        end)
        return true
      end
    end
    Util.cmp.actions.snippet_stop = function()
      if require("luasnip").expand_or_jumpable() then
        require("luasnip").unlink_current()
        return true
      end
    end
  end,
}

return M
