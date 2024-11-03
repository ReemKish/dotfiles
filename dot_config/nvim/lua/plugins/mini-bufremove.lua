return {
  'echasnovski/mini.bufremove',
  opts = {},
  keys = {
    { '<LEADER>bd', '<Cmd>lua MiniBufremove.delete()<CR>',            desc = 'Delete' },
    { '<LEADER>bD', '<Cmd>lua MiniBufremove.delete(0, desc = )<CR>',  desc = 'Delete!' },
    { '<LEADER>bw', '<Cmd>lua MiniBufremove.wipeout()<CR>',           desc = 'Wipeout' },
    { '<LEADER>bW', '<Cmd>lua MiniBufremove.wipeout(0, desc = )<CR>', desc = 'Wipeout!' },
  }
}
