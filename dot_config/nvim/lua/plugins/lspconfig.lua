return {
  {
    import = "plugins.lang",
  },
  {
    "neovim/nvim-lspconfig",
    keys = {
      {
        "<LEADER>lh",
        "<CMD>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
        desc = "Toggle Hints",
      },
      {
        "<LEADER>il",
        "<CMD>checkhealth lsp<CR>",
        desc = "LSP Info",
      },
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

          local map_lsp_action = function(lhs, action, desc)
            vim.keymap.set("n", lhs, vim.lsp.buf[action], { desc = desc, buffer = true })
          end
          map_lsp_action("gD", [[declaration]], "Goto Declaration")
          map_lsp_action("K", [[hover]], "Hover Documentation")
          if not _G.TELESCOPE_LSP_ATTACHED then -- Prefer to use telescope for these.
            map_lsp_action("gd", [[definition]], "Goto Definition")
            map_lsp_action("gt", [[type_definition]], "Goto Type Definition")
            map_lsp_action("gI", [[implementation]], "Goto Implementation")
            map_lsp_action("gr", [[references]], "References")
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
