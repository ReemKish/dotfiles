M = {}

M.insert_comment = function(prefix_keys)
  prefix_keys = prefix_keys or ""
  local comment_fmt = vim.api.nvim_get_option_value("commentstring", {})
  local empty_comment = string.format(comment_fmt, "")
  vim.api.nvim_input(prefix_keys .. empty_comment)
end

return M
