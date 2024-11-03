return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { 'markdown', 'markdown_inline' } },
  },
  {
    ft = "markdown",
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },
}
