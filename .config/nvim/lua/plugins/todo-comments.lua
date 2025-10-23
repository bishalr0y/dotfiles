return {
  "folke/todo-comments.nvim",
  event = "BufReadPre",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- PERF: fully optimised
    -- FIXME: dddddd
    -- HACK: hmmm, this looks a bit funky
    -- TODO: What else?
    -- NOTE: adding a note
    -- FIX: this needs fixing
    -- WARNING: ???
    highlight = {
      multiline = false, -- disable multiline comments
    },
  },
}
