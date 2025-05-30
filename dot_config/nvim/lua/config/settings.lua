--stylua: ignore start
-- Leader key =================================================================
vim.g.mapleader = ' '

-- General ====================================================================
vim.o.backup       = false          -- Don't store backup
vim.o.mouse        = 'a'            -- Enable mouse
vim.o.writebackup  = false          -- Don't store backup
vim.o.mousescroll  = 'ver:2,hor:2'  -- Customize mouse scroll
vim.o.switchbuf    = 'usetab'       -- Use already opened buffers when switching
vim.o.undofile     = true           -- Enable persistent undo

vim.o.shada        = "'100,<50,s10,:1000,/100,@100,h" -- Limit what is stored in ShaDa file

vim.cmd('filetype plugin indent on') -- Enable all filetype plugins


-- UI =========================================================================
vim.o.breakindent   = true      -- Indent wrapped lines to match line start
-- vim.o.colorcolumn   = '+1'      -- Draw colored column one step to the right of desired maximum width
vim.o.cursorline    = true      -- Enable highlighting of the current line
vim.o.laststatus    = 2         -- Always show statusline
vim.o.linebreak     = true      -- Wrap long lines at 'breakat' (if 'wrap' is set)
vim.o.list          = true      -- Show helpful character indicators
vim.o.number        = true      -- Show line numbers
vim.o.pumblend      = 12        -- Make builtin completion menus slightly transparent
vim.o.pumheight     = 10        -- Make popup menu smaller
vim.o.ruler         = false     -- Don't show cursor position
vim.o.shortmess     = 'oOFc'    -- Disable certain messages from |ins-completion-menu|
vim.o.showmode      = false     -- Don't show mode in command line
vim.o.showtabline   = 2         -- Always show tabline
vim.o.signcolumn    = 'yes'     -- Always show signcolumn or it would frequently shift
vim.o.splitbelow    = true      -- Horizontal splits will be below
vim.o.splitright    = true      -- Vertical splits will be to the right
vim.o.termguicolors = true      -- Enable gui colors
vim.o.winblend      = 10        -- Make floating windows slightly transparent
vim.o.wrap          = false     -- Display long lines as just one line

vim.o.fillchars = table.concat(
  { 'eob: ', 'fold:╌', 'horiz:═', 'horizdown:╦', 'horizup:╩', 'vert:║', 'verthoriz:╬', 'vertleft:╣', 'vertright:╠' },
  ','
)
vim.o.listchars = table.concat({ 'extends:…', 'nbsp:␣', 'precedes:…', 'tab:> ' }, ',')
vim.o.cursorlineopt = 'screenline,number' -- Show cursor line only screen line when wrapped
vim.o.breakindentopt = 'list:-1' -- Add padding for lists when 'wrap' is on

-- Colors =====================================================================
-- Enable syntax highlighing if it wasn't already (as it is time consuming)
-- Don't use defer it because it affects start screen appearance
if vim.fn.exists('syntax_on') ~= 1 then vim.cmd('syntax enable') end

-- Editing ====================================================================
vim.o.autoindent    = true     -- Use auto indent
vim.o.expandtab     = true     -- Convert tabs to spaces
vim.o.formatoptions = 'rqnl1j' -- Improve comment editing
vim.o.ignorecase    = true     -- Ignore case when searching (use `\C` to force not doing that)
vim.o.incsearch     = true     -- Show search results while typing
vim.o.infercase     = true     -- Infer letter cases for a richer built-in keyword completion
vim.o.shiftwidth    = 2        -- Use this number of spaces for indentation
vim.o.smartcase     = true     -- Don't ignore case when searching if pattern has upper case
vim.o.smartindent   = true     -- Make indenting smart
vim.o.tabstop       = 2        -- Insert 2 spaces for a tab
vim.o.virtualedit   = 'block'  -- Allow going past the end of line in visual block mode

vim.opt.iskeyword:append('-')  -- Treat dash separated words as a word text object

-- Define pattern for a start of 'numbered' list. This is responsible for
-- correct formatting of lists when using `gw`. This basically reads as 'at
-- least one special character (digit, -, +, *) possibly followed some
-- punctuation (. or `)`) followed by at least one space is a start of list
-- item'
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

-- Spelling ===================================================================
vim.o.spelllang    = 'en'         -- Define spelling dictionaries
vim.o.spelloptions = 'camel'      -- Treat parts of camelCase words as seprate words
vim.opt.complete:append('kspell') -- Add spellcheck options for autocomplete
vim.opt.complete:remove('t')      -- Don't use tags for completion

vim.o.dictionary = vim.fn.stdpath('config') .. '/misc/dict/english.txt' -- Use specific dictionaries

-- -- Folds ======================================================================
-- vim.o.foldmethod  = 'indent' -- Set 'indent' folding method
-- vim.o.foldlevel   = 1        -- Display all folds except top ones
-- vim.o.foldnestmax = 10       -- Create folds only for some number of nested levels
-- vim.g.markdown_folding = 1   -- Use folding by heading in markdown files
--
-- if vim.fn.has('nvim-0.10') == 1 then
--   vim.o.foldtext = ''        -- Use underlying text with its highlighting
-- end
-- Custom autocommands ========================================================
local augroup = vim.api.nvim_create_augroup('CustomSettings', {})
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  callback = function()
    -- Don't auto-wrap comments and don't insert comment leader after hitting 'o'
    -- If don't do this on `FileType`, this keeps reappearing due to being set in
    -- filetype plugins.
    vim.cmd('setlocal formatoptions-=c formatoptions-=o')
  end,
  desc = [[Ensure proper 'formatoptions']],
})
--stylua: ignore end
