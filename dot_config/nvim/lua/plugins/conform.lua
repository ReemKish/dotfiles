return {
  'stevearc/conform.nvim',
  keys = {
    {
      '<LEADER>lf',
      '<Cmd>lua require("conform").format({ lsp_fallback = true })<CR>',
      mode = 'n',
      desc = 'Format',
    },
    {
      '<LEADER>ic',
      '<CMD>ConformInfo<CR>',
      desc = 'Conform Info',
    },
  },
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo', 'FormatEnable', 'FormatDisable', 'FormatToggle' },
  opts = {
    default_format_opts = {
      lsp_format = 'fallback',
    },
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
    formatters_by_ft = {
      markdown = { 'injected' },
    },
    formatters = {
      -- ruff = {
      --   prepend_args = {
      --     '--config',
      --     'format.indent-style="tab"',
      --   },
      -- },
    },
  },
  config = function(_, opts)
    local conform_notify = function(msg) vim.notify(msg, vim.log.levels.INFO, { title = 'conform.nvim' }) end
    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
        conform_notify 'Autoformat-on-save disabled for this buffer'
      else
        vim.g.disable_autoformat = true
        conform_notify 'Autoformat-on-save disabled globally'
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    })
    vim.api.nvim_create_user_command('FormatEnable', function()
      conform_notify 'Autoformat-on-save enabled globally'
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })
    vim.api.nvim_create_user_command('FormatToggle', function(args)
      local is_global = not args.bang
      if is_global then
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        if vim.g.disable_autoformat then
          conform_notify 'Autoformat-on-save disabled globally'
        else
          conform_notify 'Autoformat-on-save enabled globally'
        end
      else
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        if vim.b.disable_autoformat then
          conform_notify 'Autoformat-on-save disabled for this buffer'
        else
          conform_notify 'Autoformat-on-save enabled for this buffer'
        end
      end
    end, {
      desc = 'Toggle autoformat-on-save',
      bang = true,
    })
    require('conform').setup(opts)
  end,
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
