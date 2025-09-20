return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = { "folke/snacks.nvim" },
  keys = {
    {
      "<leader>-",
      mode = { "n", "v" },
      "<cmd>Yazi<cr>",
      desc = "Yazi",
    },
    {
      "<c-up>",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume Yazi",
    },
  },
  ---@type YaziConfig | {}
  opts = {
    open_for_directories = true,
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end,
}
