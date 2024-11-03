return {
  'nvim-pack/nvim-spectre',
  keys = {
    {'<LEADER>s',  '',                                                                desc = '+Spectre' },
    {'<LEADER>ss', '<Cmd>lua require("spectre").toggle()<CR>',                        desc = 'Toggle Spectre' },
    {'<LEADER>sw', '<Cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = 'Search current word' },
    {'<LEADER>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', mode = 'v',  desc = 'Search current word' },
    {'<LEADER>sf', '<Cmd>lua require("spectre").open_file_search()<CR>',              desc = 'Search in current file' },
  },
  dependencies = {'nvim-lua/plenary.nvim'}
}
