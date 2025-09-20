return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "bash" } },
  },
  {
    "neovim/nvim-lspconfig",
    ft = { "bash", "sh" },
    opts = {
      servers = {
        bashls = {},
      },
    },
  },
}
