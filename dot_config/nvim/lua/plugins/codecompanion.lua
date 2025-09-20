return {
  "olimorris/codecompanion.nvim",
  enabled = true,
  opts = {
    strategies = {
        chat = {
          name = "copilot",
          model = "gpt-4.1",
        },
        inline = {
          adapter = "anthropic",
        },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
