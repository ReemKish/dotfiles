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
    },
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      -- Use LspAttach autocommand to only map the lsp keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user_lsp_config", { clear = false }),
        callback = require("config.lspmaps").on_attach
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
      for server, server_config in pairs(opts.servers) do
        vim.lsp.config(server, server_config)
        vim.lsp.enable(server)
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
    end,
  },
}
