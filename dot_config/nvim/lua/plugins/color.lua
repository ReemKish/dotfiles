return {
  {
    "navarasu/onedark.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = { style = "darker" },
    config = function() end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      colors = {
        theme = {
          wave = {
            ui = {
              bg_m3      = "#0d0c0c",
              bg_m2      = "#12120f",
              bg_m1      = "#1D1C19",
              bg         = "#181616",
              bg_p1      = "#282727",
              bg_p2      = "#393836",
            }
          },
          all = {
            ui = {
              bg_gutter = "none"
            }
          }
        }
      },
      overrides = function(colors)
        return {
          SnacksIndent = { fg = colors.palette.sumiInk5, italic = true },
        }
      end,
    },
    config = function(_, opts)
      require('kanagawa').setup(opts)
      vim.cmd[[colorscheme kanagawa-wave]]
    end,
  },
  {
    "sainnhe/sonokai",
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function() end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {},
    config = function() end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    name = "catppuccin",
    opts = {
      integrations = {
        aerial = true,
        dashboard = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },
    },
  },

  {
    "echasnovski/mini.colors",
    opts = {},
  },
}
