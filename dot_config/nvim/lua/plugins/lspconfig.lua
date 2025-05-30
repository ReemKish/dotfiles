return {
  {
    import = "plugins.lang",
  },
  {
    "neovim/nvim-lspconfig",
    keys = {
      {
        "<leader>il",
        "<CMD>checkhealth lsp<CR>",
        desc = "LSP Info",
      },
      -- {
      --   "<leader>ca",
      --   vim.lsp.buf.code_action,
      --   desc = "Code Action"
      -- }
    },
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user_lsp_config", { clear = false }),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.bo[ev.buf].formatexpr = nil
          local key_specs = {
            { "K", function() return vim.lsp.buf.hover() end, desc = "Hover" },
            { "gK", function() return vim.lsp.buf.signature_help() end, desc = "Signature Help", has = "signatureHelp" },
            { "<c-k>", function() return vim.lsp.buf.signature_help() end, mode = "i", desc = "Signature Help", has = "signatureHelp" },
            { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
            { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
            { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
            { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
            { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
            { "]]", function() Snacks.words.jump(vim.v.count1) end, has = "documentHighlight",
              desc = "Next Reference", cond = function() return Snacks.words.is_enabled() end },
            { "[[", function() Snacks.words.jump(-vim.v.count1) end, has = "documentHighlight",
              desc = "Prev Reference", cond = function() return Snacks.words.is_enabled() end },
            { "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, has = "documentHighlight",
              desc = "Next Reference", cond = function() return Snacks.words.is_enabled() end },
            { "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, has = "documentHighlight",
              desc = "Prev Reference", cond = function() return Snacks.words.is_enabled() end },
          }

          for _, key_spec in ipairs(key_specs) do
            -- TODO: use 'has' and 'cond' fields to confitionally set mappings.
            local mode = key_spec.mode or "n"
            local lhs = key_spec[0]
            local action = key_spec[1]
            vim.keymap.set(mode, key_spec[1], key_spec[2], { desc = key_spec.desc, buffer = true})
          end
        end,
      })
    end,
    opts = function(_, opts)
      local icons = require "util.icons"
      opts.diagnostics = {
        severity_sort = true,
        signs = { -- Show gutter signs.
          priority = 100,
          -- severity = { min = 'WARN', max = 'ERROR' }, -- Only for warnings and errors.
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
          },
        },
        virtual_text = { -- Show virtual text only for errors.
          severity = { min = "ERROR", max = "ERROR" },
          prefix = icons.diagnostics.Indicator,
        },
        underline = true, -- Underline erronous element.
        update_in_insert = false, -- Don't update diagnostics when typing.
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "", -- Remove 'Diagnotics:' default header
          prefix = "", -- Remove '1. 2. 3. ..' default prefix
        },
      }
    end,
    config = function(_, opts)
      local lspconfig = require "lspconfig"
      for server, server_config in pairs(opts.servers) do
        lspconfig[server].setup(server_config)
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
    end,
  },
}
