M = {}

M.select_code_action = function()
  vim.lsp.buf.code_action {
    filter = function(codeaction)
      local ok, disabled_codeactions = pcall(vim.api.nvim_buf_get_var, 0, "disabled_codeactions")
      disabled_codeactions = ok and disabled_codeactions or {}
      for _, action in ipairs(disabled_codeactions) do
        if string.find(codeaction.title, action) then
          return false
        end
      end
      return true
    end,
  }
end

M.action = setmetatable({}, {
  __index = function(_, action)
    return function()
      vim.lsp.buf.code_action {
        apply = true,
        context = {
          only = { action },
          diagnostics = {},
        },
      }
    end
  end,
})

return M
