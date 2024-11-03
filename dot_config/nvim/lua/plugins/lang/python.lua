return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "python" } },
  },
  {
    "neovim/nvim-lspconfig",
    keys = {
      {
        "<LEADER>co",
        require("util.lsp").action["source.organizeImports"],
        desc = "Organize imports",
        ft = "python",
      },
      {
        "<LEADER>cF",
        require("util.lsp").action["source.fixAll"],
        desc = "Fix all",
        ft = "python",
      },
    },
    opts = {
      servers = {
        ruff = {
          init_options = {
            settings = {
              showSyntaxErrors = false, -- Avoid conflict with Pyright.
              lineLength = 88,
              lint = {
                preview = true,
                extendSelect = { "ARG", "RUF", "I", "PT" },
                ignore = {
                  -- Avoid conflict with Pyright.
                  "F407",
                  -- Annoying
                  "E741",
                },
              },
            },
          },
          on_attach = function(client, bufnr) -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end,
        },

        pyright = {
          capabilities = {
            textDocument = {
              publishDiagnostics = {
                tagSupport = {
                  valueSet = { 2 }, -- Discard some diagnostics to avoid conflict with Ruff.
                },
              },
              completions = {
                completionItem = {
                  snippetSupport = true,
                },
              },
            },
          },
          settings = {
            pyright = {
              disableOrganizeImports = true, -- Use Ruff's import organizer
            },
            python = {
              analysis = {
                diagnosticSeverityOverrides = {
                  reportUndefinedVariable = "none", -- Avoid conflict with Ruff.
                },
                -- ignore = { '*' }, -- Ignore all files for analysis to exclusively use Ruff for linting.
              },
            },
          },
        },
      },
    },
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {},
      },
    },
  },

  -- {
  --   "mfussenegger/nvim-dap",
  --   optional = true,
  --   dependencies = {
  --     "mfussenegger/nvim-dap-python",
  --     -- stylua: ignore
  --     keys = {
  --       { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
  --       { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
  --     },
  --     config = function()
  --       if vim.fn.has("win32") == 1 then
  --         require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
  --       else
  --         require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/bin/python"))
  --       end
  --     end,
  --   },
  -- },

  -- {
  --   "linux-cultist/venv-selector.nvim",
  --   branch = "regexp", -- Use this branch for the new version
  --   cmd = "VenvSelect",
  --   enabled = function()
  --     return LazyVim.has("telescope.nvim")
  --   end,
  --   opts = {
  --     settings = {
  --       options = {
  --         notify_user_on_venv_activation = true,
  --       },
  --     },
  --   },
  --   --  Call config for python files and load the cached venv automatically
  --   ft = "python",
  --   keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  -- },
}
