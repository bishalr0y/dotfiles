return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  init = function()
    -- We own <C-h/j/k/l> (see lua/herdr-nav.lua). Keep vim-tmux-navigator only
    -- for its TmuxNavigate* commands, which herdr-nav uses as the tmux fallback
    -- when running outside herdr.
    vim.g.tmux_navigator_no_mappings = 1
  end,
  config = function()
    -- LazyVim installs its own <C-h/j/k/l> window maps on VeryLazy, so set ours
    -- afterwards to win.
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      once = true,
      callback = function()
        vim.schedule(function()
          require("herdr-nav").setup()
        end)
      end,
    })
  end,
}
