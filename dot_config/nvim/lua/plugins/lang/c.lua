return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "c", "make", "cmake" } },
  },
  {
    "neovim/nvim-lspconfig",
    ft = "c",
    opts = {
      servers = {
        clangd = {},
      },
    },
  },
}
