return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "cpp", "make", "cmake" } },
  },
  {
    "neovim/nvim-lspconfig",
    -- keys = {
    --   {
    --     "<LEADER>co",
    --     require("util.lsp").action["source.organizeImports"],
    --     desc = "Organize imports",
    --     ft = "python",
    --   },
    --   {
    --     "<LEADER>cF",
    --     require("util.lsp").action["source.fixAll"],
    --     desc = "Fix all",
    --     ft = "python",
    --   },
    -- },
    ft = "cpp",
    opts = {
      servers = {
        clangd = {},
      },
    },
  },
}
