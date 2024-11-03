return {
  "folke/noice.nvim",
  keys = {
    { "<LEADER>n", "", desc = "+Noice" },
    {
      "<S-Enter>",
      function()
        require("noice").redirect(vim.fn.getcmdline())
      end,
      desc = "Redirect Cmdline",
      mode = "c",
    },
    {
      "<LEADER>nl",
      function()
        require("noice").cmd("last")
      end,
      desc = "Noice Last Message",
    },
    {
      "<LEADER>nh",
      function()
        require("noice").cmd("history")
      end,
      desc = "Noice History",
    },
    {
      "<LEADER>na",
      function()
        require("noice").cmd("all")
      end,
      desc = "Noice All",
    },
    {
      "<LEADER>nd",
      function()
        require("noice").cmd("dismiss")
      end,
      desc = "Dismiss All",
    },
    {
      "<LEADER>nt",
      function()
        require("noice").cmd("pick")
      end,
      desc = "Noice Telescope",
    },
  },
  event = "VeryLazy",
  opts = {
    cmdline = {
      enabled = true,
      menu = "popup",
      format = {
        -- search_down = { kind = "search", pattern = "^/", icon = "/", lang = "regex" },
        -- search_up = { kind = "search", pattern = "^%?", icon = "?", lang = "regex" },
      },
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      lsp_doc_border = true, -- add a border to hover docs and signature help
      -- cmdline_output_to_split = true, -- command output will be sent to a split
    },
    routes = {
      { -- Show `recording @` message on classic cmdline.
        filter = { event = "msg_showmode" },
        view = "cmdline",
      },
      { -- Hide undo/redo & `written` messages
        filter = {
          any = {
            { event = "msg_show", kind = "", find = "written" },
            { event = "msg_show", kind = "", find = "%d+ .*; before #%d+" },
            { event = "msg_show", kind = "", find = "%d+ .*; after #%d+" },
            { event = "msg_show", kind = "", find = "Already at newest change" },
          },
        },
        opts = { skip = true },
      },
    },
  },
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function(_, opts)
    -- HACK: noice shows messages from before it was enabled,
    -- but this is not ideal when Lazy is installing plugins,
    -- so clear the messages in this case.
    if vim.o.filetype == "lazy" then
      vim.cmd([[messages clear]])
    end
    require("noice").setup(opts)
  end,
}
