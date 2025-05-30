-- stylua: ignore start

-- Create `<leader>` mappings
local nmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('n', '<leader>' .. suffix, rhs, opts)
end

nmap_leader([[h]], '<cmd>let v:hlsearch = 1 - v:hlsearch<cr>', '')
nmap_leader([[ih]],  '<cmd>checkhealth<cr>',                                      'Check Health')
