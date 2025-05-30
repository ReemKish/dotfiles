return {
  'echasnovski/mini.map',
  opts = {},
  keys = {
    { [[<LEADER>mc]], '<CMD>lua MiniMap.close()<CR>',         desc = 'Close' },
    { [[<LEADER>mf]], '<CMD>lua MiniMap.toggle_focus()<CR>',  desc = 'Focus (toggle)' },
    { [[<LEADER>mo]], '<CMD>lua MiniMap.open()<CR>',          desc = 'Open' },
    { [[<LEADER>mr]], '<CMD>lua MiniMap.refresh()<CR>',       desc = 'Refresh' },
    { [[<LEADER>ms]], '<CMD>lua MiniMap.toggle_side()<CR>',   desc = 'Side (toggle)' },
    { [[<LEADER>mt]], '<CMD>lua MiniMap.toggle()<CR>',        desc = 'Toggle' },
  }
}
