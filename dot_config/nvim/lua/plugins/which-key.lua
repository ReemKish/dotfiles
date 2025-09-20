return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    filter = function(mapping)
      return mapping.desc and mapping.desc ~= ""
    end,
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>c", group = "Code" },
        { "<leader>f", group = "File", icon = "󰱼" },
        { "<leader>g", group = "Git" },
        { "<leader>m", group = "Map", icon = "" },
        { "<leader>s", group = "Search" },
        { "<leader>i", group = "Info", icon = "" },
        { "<leader>e", group = "Explore", icon = "󱉯" },
        { "<leader>t", group = "Test"},
        { "<leader>v", group = "Visits", icon = "" },
        { "<leader>q", group = "Quit/Session" },
        { "<leader>o", group = "Overseer" },
        { "<leader>u", group = "UI", icon = { icon = "󰙵 ", color = "cyan" } },
        { "<leader>x", group = "Diagnostics/Quickfix", icon = { icon = "󱖫 ", color = "green" } },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "z", group = "fold" },
        {
          "<leader>b",
          group = "Buffer",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
        {
          "<leader>w",
          group = "Windows",
          proxy = "<c-w>",
          expand = function()
            return require("which-key.extras").expand.win()
          end,
        },
        -- better descriptions
        { "gx", desc = "Open with system app" },
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps",
    },
  },
}
