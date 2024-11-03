vim.api.nvim_buf_set_keymap(0, "i", "<M-i>", " = ", { noremap = true })

-- Use custom comment leaders to allow both nested variants (`--` and `----`)
-- and "docgen" variant (`---`).
vim.bo.comments = ":---,:--"

-- Customize 'mini.nvim'
vim.b.miniai_config = {
  custom_textobjects = {
    s = { "%[%[().-()%]%]" },
  },
}

vim.b.minisurround_config = {
  custom_surroundings = {
    s = { input = { "%[%[().-()%]%]" }, output = { left = "[[", right = "]]" } },
  },
}

-- if MiniSnippets ~= nil then
--   local find = function(snippets) return MiniSnippets.default_find(snippets, { pattern = '[%w@_]+' }) end
--   vim.b.minisnippets_config = { match = { find = find } }
-- end

vim.api.nvim_buf_set_var(0, "disabled_codeactions", {
  "Change to parameter",
})

vim.api.nvim_buf_set_var(0, "lightbulb_ignore_codeactions", {
  "Change to parameter",
  "Disable diagnostics",
})
