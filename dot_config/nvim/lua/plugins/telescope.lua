return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  tag = "0.1.8",
  keys = {
    { "<LEADER>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    { "<LEADER>/", "<Cmd>Telescope live_grep<CR>", desc = "Grep (Root Dir)" },
    { "<LEADER>:", "<Cmd>Telescope command_history<CR>", desc = "Command History" },
    { "<LEADER><SPACE>", "<Cmd>Telescope find_files<CR>", desc = "Find Files (Root Dir)" },

    { "<LEADER>fh", "<Cmd>Telescope help_tags<CR>", desc = "Help tags" },
    { "<LEADER>fs", "<Cmd>Telescope lsp_workspace_symbols<CR>", desc = "Symbols (workspace) (LSP)" },
    { "<LEADER>fS", "<Cmd>Telescope lsp_document_symbols<CR>", desc = "Symbols (buffer)    (LSP)" },
    { "<LEADER>fd", "<Cmd>Telescope diagnostics<CR>", desc = "Diagnostics         (LSP)" },
    { "<LEADER>fr", "<Cmd>Telescope resume<CR>", desc = "Resume" },
    { "<LEADER>ff", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Fuzzy Find (buffer)" },
  },
  init = function()
    -- Override buffer-local LSP mappings with better telescope alternatives.
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("user_lsp_config", { clear = false }),
      callback = function(ev)
        local map_telescope_action = function(lhs, action, desc)
          vim.keymap.set("n", lhs, function()
            require("telescope.builtin")[action]({ reuse_win = true })
          end, { desc = desc, buffer = true })
        end
        map_telescope_action("gd", [[lsp_definitions]], "Goto Definition")
        map_telescope_action("gt", [[lsp_type_definitions]], "Goto Type Definition")
        map_telescope_action("gI", [[lsp_implementations]], "Goto Implementation")
        map_telescope_action("gr", [[lsp_references]], "References")
        _G.TELESCOPE_LSP_ATTACHED = true
      end,
    })

    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require("lazy").load({ plugins = { "telescope.nvim" } })
      return vim.ui.select(...)
    end
  end,

  config = function()
    local actions = require "telescope.actions"
    local icons = require "util.icons"
    require("telescope").setup({
      defaults = {
        prompt_prefix = icons.ui.Prompt .. " ",
        selection_caret = icons.ui.TriangleShortArrowRight .. " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        path_display = { "smart" },
        color_devicons = true,
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,

            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
          n = {
            ["<esc>"] = actions.close,
            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["q"] = actions.close,
          },
        },
      },
      pickers = {
        live_grep = {
          theme = "dropdown",
        },

        grep_string = {
          theme = "dropdown",
        },

        find_files = {
          theme = "dropdown",
          previewer = false,
        },

        buffers = {
          theme = "dropdown",
          previewer = false,
          initial_mode = "normal",
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
            n = {
              ["dd"] = actions.delete_buffer,
            },
          },
        },

        colorscheme = {
          enable_preview = true,
        },

        lsp_references = {
          theme = "dropdown",
          initial_mode = "normal",
        },

        lsp_definitions = {
          theme = "dropdown",
          initial_mode = "normal",
        },

        lsp_declarations = {
          theme = "dropdown",
          initial_mode = "normal",
        },

        lsp_implementations = {
          theme = "dropdown",
          initial_mode = "normal",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        ["ui-select"] = {
          require("telescope.themes").get_cursor {
            initial_mode = "normal",
            layout_config = { width = 60 },
          },
        },
      },
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
  end,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-ui-select.nvim" },
  },
}
