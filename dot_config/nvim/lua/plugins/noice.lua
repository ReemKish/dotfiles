return {
  "folke/noice.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    -- Aim to use noice.nvim only for the pretty commandline.
    messages = { enabled = false },
    popupmenu = { enabled = false },
    notify = { enabled = false },
    lsp = { enabled = false },
    presets = {
      bottom_search = true,
      command_palette = true,
    },
  },
  config = function(_, opts)
    -- HACK: noice shows messages from before it was enabled,
    -- but this is not ideal when Lazy is installing plugins,
    -- so clear the messages in this case.
    if vim.o.filetype == "lazy" then
      vim.cmd([[messages clear]])
    end
    require("noice").setup(opts)
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}
