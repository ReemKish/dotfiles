-- stylua: ignore start

-- Create `<LEADER>` mappings
local nmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('n', '<LEADER>' .. suffix, rhs, opts)
end
local xmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('x', '<LEADER>' .. suffix, rhs, opts)
end

nmap_leader([[h]], '<CMD>let v:hlsearch = 1 - v:hlsearch<CR>', 'Toggle Search Highlight')


-- b is for 'buffer'
nmap_leader([[b]],  '',                           '+Buffer')
nmap_leader([[ba]], '<Cmd>b#<CR>',                'Alternate')
nmap_leader([[bs]], '<Cmd>ene | startinsert<CR>', 'Scratch')

-- g is for git
nmap_leader([[g]],  '',                                         '+Git')
nmap_leader([[gc]], '<Cmd>Git commit<CR>',                      'Commit')
nmap_leader([[gC]], '<Cmd>Git commit --amend<CR>',              'Commit amend')
nmap_leader([[gg]], '<Cmd>lua Config.open_lazygit()<CR>',       'Git tab')
nmap_leader([[gl]], '<Cmd>Git log --oneline<CR>',               'Log')
nmap_leader([[gL]], '<Cmd>Git log --oneline --follow -- %<CR>', 'Log buffer')
nmap_leader([[go]], '<Cmd>lua MiniDiff.toggle_overlay()<CR>',   'Toggle overlay')
nmap_leader([[gs]], '<Cmd>lua MiniGit.show_at_cursor()<CR>',    'Show at cursor')
xmap_leader([[gs]], '<Cmd>lua MiniGit.show_at_cursor()<CR>',    'Show at selection')

-- o is for 'other'
local trailspace_toggle_command = '<Cmd>lua vim.b.minitrailspace_disable = not vim.b.minitrailspace_disable<CR>'
nmap_leader([[o]],  '',                                      '+Other')
nmap_leader([[oC]], '<Cmd>lua MiniCursorword.toggle()<CR>',  'Cursor word hl toggle')
nmap_leader([[od]], '<Cmd>Neogen<CR>',                       'Document')
nmap_leader([[oH]], '<Cmd>TSBufToggle highlight<CR>',        'TS Highlight toggle')
nmap_leader([[or]], '<Cmd>lua MiniMisc.resize_window()<CR>', 'Resize to default width')
nmap_leader([[os]], '<Cmd>lua MiniSessions.select()<CR>',    'Session select')
nmap_leader([[oS]], '<Cmd>lua Config.insert_section()<CR>',  'Section insert')
nmap_leader([[oz]], '<Cmd>lua MiniMisc.zoom()<CR>',          'Zoom toggle')

-- i is for 'info'
nmap_leader([[i]],  '',                                      '+Info')
nmap_leader([[ih]],  '<CMD>checkhealth<CR>',                                      'Check Health')

-- -- t is for 'terminal' (uses 'neoterm')
-- nmap_leader([[tT]], '<Cmd>belowright Tnew<CR>',                          'Terminal (horizontal)')
-- nmap_leader([[tt]], '<Cmd>vertical Tnew<CR>',                            'Terminal (vertical)')

-- -- c is for 'code'
nmap_leader([[c]],  '',                            '+Code')
nmap_leader([[cd]], vim.diagnostic.open_float, 'Line Diagnostics')
nmap_leader([[ca]], require('util.lsp').select_code_action,   'Code Action')

-- -- C is for 'color'
nmap_leader([[C]],   '',                            '+Color')
nmap_leader([[Cc]],  'Telescope colorscheme',       'Choose Colorscheme')

-- lsp
nmap_leader([[l]],  '',                         '+LSP')
nmap_leader([[li]], '<CMD>check lspconfig<CR>', 'Info')
nmap_leader([[ld]], vim.diagnostic.open_float,  'Line Diagnostics')
nmap_leader([[ll]], vim.lsp.codelens.run,       'CodeLens Action')
nmap_leader([[lq]], vim.diagnostic.setloclist,  'Quickfix')
nmap_leader([[lr]], vim.lsp.buf.rename,         'Rename')

-- stylua: ignore end
