return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  init = function()
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
          for key, dir in pairs({ h = "Left", j = "Down", k = "Up", l = "Right" }) do
            vim.keymap.set("n", "<C-" .. key .. ">", "<cmd>TmuxNavigate" .. dir .. "<cr>", {
              silent = true,
              desc = "Navigate " .. dir:lower(),
            })
          end
        end)
      end,
    })
  end,
}
