return {
  "echasnovski/mini.bracketed",
  opts = {
    {
      -- First-level elements are tables describing behavior of a target:
      --
      -- - <suffix> - single character suffix. Used after `[` / `]` in mappings.
      --   For example, with `b` creates `[B`, `[b`, `]b`, `]B` mappings.
      --   Supply empty string `''` to not create mappings.
      --
      -- - <options> - table overriding target options.
      --
      -- See `:h MiniBracketed.config` for more info.

      buffer      = { suffix = "b", options = {} },
      conflict    = { suffix = "x", options = {} },
      diagnostic  = { suffix = "d", options = {} },
      jump        = { suffix = "j", options = {} },
      location    = { suffix = "l", options = {} },
      quickfix    = { suffix = "q", options = {} },
      comment     = { suffix = "",  options = {} },
      file        = { suffix = "",  options = {} },
      indent      = { suffix = "",  options = {} },
      oldfile     = { suffix = "",  options = {} },
      treesitter  = { suffix = "",  options = {} },
      undo        = { suffix = "",  options = {} },
      window      = { suffix = "",  options = {} },
      yank        = { suffix = "",  options = {} },
    },
  },
}
