local M = {}

M._keys = nil

function M.get()
  if M._keys then
    return M._keys
  end
    -- stylua: ignore
    M._keys =  {
      { "<leader>cl", function() Snacks.picker.lsp_config() end, desc = "Lsp Info" },
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      { "K", function() return vim.lsp.buf.hover() end, desc = "Hover" },
      { "gK", function() return vim.lsp.buf.signature_help() end, desc = "Signature Help" },
      { "<c-k>", function() return vim.lsp.buf.signature_help() end, mode = "i", desc = "Signature Help" },
      { "<leader>ca", Util.lsp.code_action, desc = "Code Action", mode = { "n", "v" } },
      { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" } },
      { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" } },
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File", mode = {"n"} },
      { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference" },
      { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
      { "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, desc = "Next Reference" },
      { "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, desc = "Prev Reference" },
    }

  return M._keys
end

function M.on_attach(ev)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
  vim.bo[ev.buf].formatexpr = nil
  for _, map in ipairs(require("config.lspmaps").get()) do
    local mode = map.mode or "n"
    local expr = map.expr or false
    local lhs = map[1]
    local rhs = map[2]
    vim.keymap.set(mode, lhs, rhs, { desc = map.desc, buffer = true, expr = expr })
  end
end

return M
