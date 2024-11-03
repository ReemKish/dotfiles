return {
  "echasnovski/mini.visits",
  opts = {},
  keys = {
    { [[<LEADER>v]],  '',                                             desc = '+Visits' },
    { [[<LEADER>vv]], '<Cmd>lua MiniVisits.add_label("core")<CR>',    desc = 'Add "core" label' },
    { [[<LEADER>vV]], '<Cmd>lua MiniVisits.remove_label("core")<CR>', desc = 'Remove "core" label' },
    { [[<LEADER>vl]], '<Cmd>lua MiniVisits.add_label()<CR>',          desc = 'Add label' },
    { [[<LEADER>vL]], '<Cmd>lua MiniVisits.remove_label()<CR>',       desc = 'Remove label' },
  }
}
