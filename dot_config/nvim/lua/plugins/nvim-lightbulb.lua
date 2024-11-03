return {
  "kosayoda/nvim-lightbulb",
  event = "LspAttach",
  opts = function()
    -- Map lsp clients to a list of substrings of codeactions to filter.
    -- e.g. Ruff displays 'Fix all ...' codeaction regardless of context, which
    -- triggers the lightbulb on every line - rendering it redundant, thus we ignore it.
    -- local ignore_codeactions = {}
    return {
      priority = 1000, -- Should be greater priorty then diagnostic signs.
      code_lenses = true,
      autocmd = {
        enabled = true,
      },
      filter = function(_, codeaction)
        local ok, ignore_codeactions = pcall(vim.api.nvim_buf_get_var, 0, "lightbulb_ignore_codeactions")
        ignore_codeactions = ok and ignore_codeactions or {}
        for _, ignore_codeaction in ipairs(ignore_codeactions) do
          if string.find(codeaction.title, ignore_codeaction) then
            return false
          end
        end
        return true
      end,
    }
  end,
}
