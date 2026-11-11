return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  init = function()
    -- <C-h/j/k/l> live in lua/herdr-nav.lua (Neovim splits + herdr edge). This
    -- plugin supplies TmuxNavigate* for tmux fallback only; mappings stay off.
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
