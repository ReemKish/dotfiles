return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "toml" } },
  },
  {
    "neovim/nvim-lspconfig",
    ft = 'toml',
    opts = {
      servers = {
        taplo = {}
      }
    }
  }
}
