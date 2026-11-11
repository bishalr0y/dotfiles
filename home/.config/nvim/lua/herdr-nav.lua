-- <C-h/j/k/l> in Neovim: move between windows; at an edge, cross into herdr-app
-- panes (HC_TERMINAL_ID) or herdr-tui (HERDR_PANE_ID). Herdr-app does not bind
-- these keys — they reach Neovim directly. Use <C-;> h/j/k/l in herdr-app for
-- explicit pane focus everywhere (see keys.json).
--
-- Vendored from paulbkim-dev/vim-herdr-navigation (editor/nvim.lua), with fixes
-- for stale HERDR_BIN_PATH (#15) and failed edge-cross notify (#17).
-- tmux fallback uses vim-tmux-navigator commands when TMUX is set.

local M = {}

local tmux_command = { left = "Left", down = "Down", up = "Up", right = "Right" }

local function herdr_bin()
  local bin = vim.env.HERDR_BIN_PATH
  if bin and bin ~= "" and vim.fn.executable(bin) == 1 then
    return bin
  end
  if vim.fn.executable("herdr") == 1 then
    return "herdr"
  end
  return nil
end

local function focus_herdr_tui(dir)
  local pane = vim.env.HERDR_PANE_ID
  if pane == nil or pane == "" then
    return false
  end

  local bin = herdr_bin()
  if bin == nil then
    vim.notify(
      "herdr-nav: no usable herdr binary (stale HERDR_BIN_PATH and herdr not on PATH)",
      vim.log.levels.ERROR
    )
    return true
  end

  local out = vim.fn.system({ bin, "pane", "focus", "--direction", dir, "--pane", pane })
  if vim.v.shell_error ~= 0 then
    vim.notify(
      "herdr-nav: `herdr pane focus --direction " .. dir .. "` failed: " .. vim.trim(out),
      vim.log.levels.ERROR
    )
  end
  return true
end

local function focus_herdr_app(dir)
  if not vim.env.HC_TERMINAL_ID or vim.env.HC_TERMINAL_ID == "" then
    return false
  end
  if vim.fn.executable("herdr-app") ~= 1 then
    return false
  end

  local out = vim.fn.system({ "herdr-app", "do", "pane.go", "--direction", dir })
  if vim.v.shell_error ~= 0 then
    vim.notify(
      "herdr-nav: `herdr-app do pane.go --direction " .. dir .. "` failed: " .. vim.trim(out),
      vim.log.levels.ERROR
    )
  end
  return true
end

function M.navigate(wincmd, dir)
  local prev = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. wincmd)
  if vim.api.nvim_get_current_win() ~= prev then
    return
  end

  if focus_herdr_tui(dir) then
    return
  end
  if focus_herdr_app(dir) then
    return
  end

  local cmd = "TmuxNavigate" .. tmux_command[dir]
  if vim.env.TMUX and vim.env.TMUX ~= "" and vim.fn.exists(":" .. cmd) == 2 then
    pcall(vim.cmd, cmd)
  end
end

local mappings = {
  { "<C-h>", "h", "left", "Neovim/herdr left" },
  { "<C-j>", "j", "down", "Neovim/herdr down" },
  { "<C-k>", "k", "up", "Neovim/herdr up" },
  { "<C-l>", "l", "right", "Neovim/herdr right" },
}

function M.setup()
  for _, m in ipairs(mappings) do
    vim.keymap.set("n", m[1], function()
      M.navigate(m[2], m[3])
    end, { silent = true, noremap = true, desc = m[4] })
  end
end

return M
