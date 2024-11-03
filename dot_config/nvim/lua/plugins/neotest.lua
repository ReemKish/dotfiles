return {
  {
    "nvim-neotest/neotest",
    -- stylua: ignore
    keys = {
      { [[<LEADER>t]],  "",                                                           desc = "+Test"                },
      { [[<LEADER>tt]], function() require'neotest'.run.run()                   end,  desc = "Test Nearest"         },
      { [[<LEADER>tf]], function() require'neotest'.run.run(vim.fn.expand('%')) end,  desc = "Test File"            },
      { [[<LEADER>tS]], function() require'neotest'.run.stop()                  end,  desc = "Stop Test"            },
      { [[<LEADER>ta]], function() require'neotest'.run.attach()                end,  desc = "Attach Test"          },
      { [[<LEADER>tl]], function() require'neotest'.run.run_last()              end,  desc = "Test Last"            },
      { [[<LEADER>ts]], function() require'neotest'.summary.toggle()            end,  desc = "Toggle Summary"       },
      { [[<LEADER>tO]], function() require'neotest'.output_panel.toggle()       end,  desc = "Toggle Output Panel"  },
      { [[<LEADER>to]], function() require'neotest'.output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
    },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {},
      -- status = { virtual_text = true },
      -- output = { open_on_run = false },
      quickfix = {
        open = function()
          require("trouble").open({ mode = "quickfix", focus = false })
        end,
      },
    },
    config = function(_, opts)
      -- local neotest_ns = vim.api.nvim_create_namespace("neotest")
      -- vim.diagnostic.config({
      --   virtual_text = {
      --     format = function(diagnostic)
      --       -- Replace newline and tab characters with space for more compact diagnostics
      --       local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
      --       return message
      --     end,
      --   },
      -- }, neotest_ns)

      opts.consumers = opts.consumers or {}
      -- Refresh and auto close trouble after running tests
      ---@type neotest.Consumer
      opts.consumers.trouble = function(client)
        client.listeners.results = function(adapter_id, results, partial)
          if partial then
            return
          end
          local tree = assert(client:get_position(nil, { adapter = adapter_id }))
          local failed = 0
          for pos_id, result in pairs(results) do
            if result.status == "failed" and tree:get_key(pos_id) then
              failed = failed + 1
            end
          end
          vim.schedule(function()
            local trouble = require("trouble")
            if trouble.is_open() then
              trouble.refresh()
              if failed == 0 then
                trouble.close()
              end
            end
          end)
          return {}
        end
      end

      -- Taken form LazyVim, this is to allow specificying adapter configuratation via table.
      local adapters = {}
      for name, config in pairs(opts.adapters or {}) do
        local adapter = require(name)
        local meta = getmetatable(adapter)
        if adapter.setup then
          adapter.setup(config)
        elseif adapter.adapter then
          adapter.adapter(config)
          adapter = adapter.adapter
        elseif meta and meta.__call then
          adapter(config)
        end
        adapters[#adapters + 1] = adapter
        opts.adapters = adapters

        require("neotest").setup(opts)
      end
    end,
  },
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = {
      { [[<leader>td]], function() require'neotest'.run.run({strategy = 'dap'}) end,  desc = "Debug Nearest" },
    },
  },
}
