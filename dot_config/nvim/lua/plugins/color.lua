return {
  {
    "navarasu/onedark.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = { style = "darker", transparent = true },
    config = function(_, opts)
      require("onedark").setup(opts)
      require("onedark").load()
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
