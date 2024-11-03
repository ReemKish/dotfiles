return {
  "Saghen/blink.cmp",
  config = true,
  -- use a release tag to download pre-built binaries
  version = "v0.*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },
      ["<Tab>"] = {
        function(cmp)
          if cmp.is_in_snippet() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<Up>"] = { "select_prev" },
      ["<Down>"] = { "select_next" },
      ["<C-j>"] = { "select_next" },
      ["<C-k>"] = { "select_prev" },
    },

    accept = {
      auto_brackets = {
        enabled = false,
      },
    },

    trigger = {
      completion = {
        show_in_snippet = false, -- when false, will not show the completion window when in a snippet
        blocked_trigger_characters = { " ", "\n", "\t", ",", "{" },
      },
    },

    signature_help = {
      enabled = true,
    },

    fuzzy = {
      use_frecency = true, -- frencency tracks the most recently/frequently used items and boosts the score of the item
      use_proximity = true, -- proximity bonus boosts the score of items with a value in the buffer
    },

    sources = {
      snippets = {
        opts = {
          score_offset = -1, -- The default is -3 which pushes snippet completions to bottom of the list.
        },
      },
    },

    windows = {
      autocomplete = {},
      documentation = {
        auto_show = false,
      },
      signature_help = {
        border = "double",
      },
    },

    highlight = {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      use_nvim_cmp_as_default = true,
    },

    -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- adjusts spacing to ensure icons are aligned
    nerd_font_variant = "mono",
  },
}
