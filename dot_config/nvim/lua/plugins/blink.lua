return {
  "Saghen/blink.cmp",
  config = true,
  version = "*",

  --@module 'blink.cmp'
  --@type blink.cmp.Config
  opts = {
    enabled = function()
      return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
    end,
    keymap = {
      preset = "super-tab",
      ["<C-p>"] = {},
      ["<C-n>"] = {},
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
    },

    completion = {
      accept = { auto_brackets = { enabled = false } },
      menu = {
        draw = {
          treesitter = { "lsp" },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
      trigger = {
        show_on_blocked_trigger_characters = function()
          if vim.api.nvim_get_mode().mode == "c" then
            return {}
          end
          return { " ", "\n", "\t", ",", "{" }
        end,
      },
    },

    sources = {
      min_keyword_length = function()
        return vim.bo.filetype == "markdown" and 3 or 0
      end,
    },

    signature = {
      enabled = true,
      window = {
        border = "single",
      },
    },

    cmdline = {
      keymap = { preset = 'inherit' },
      completion = { menu = { auto_show = true } },
    },

    fuzzy = {
      use_proximity = true, -- proximity bonus boosts the score of items with a value in the buffer
      frecency = { enabled = true },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
    },
  },
}
