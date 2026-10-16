-- Seamless <C-h/j/k/l> navigation between Neovim splits and herdr panes.
--
-- Vendored from paulbkim-dev/vim-herdr-navigation (editor/nvim.lua) so the
-- Neovim side is not tied to herdr's hash-suffixed plugin directory. Carries
-- two fixes over upstream:
--   * resolve the herdr binary defensively. After `herdr update` replaces the
--     binary while the server keeps running, the injected HERDR_BIN_PATH points
--     at a deleted inode (".../herdr (deleted)"), which broke every edge
--     crossing (upstream issue #15).
--   * surface failures via vim.notify instead of silently doing nothing
--     (upstream issue #17).
--
-- Behaviour: move between Neovim splits first; at a split edge hand off to
-- herdr. Outside herdr it falls back to tmux (if present), so an existing
-- vim-tmux-navigator setup keeps working.

local M = {}

local tmux_command = { left = "Left", down = "Down", up = "Up", right = "Right" }

local function herdr_bin()
  local bin = vim.env.HERDR_BIN_PATH
  if bin and bin ~= "" and vim.fn.executable(bin) == 1 then
    return bin
  end
  -- Stale HERDR_BIN_PATH, or unset: fall back to whatever is on PATH.
  if vim.fn.executable("herdr") == 1 then
    return "herdr"
  end
  return nil
end

local function focus_herdr(dir)
  local pane = vim.env.HERDR_PANE_ID
  if pane == nil or pane == "" then
    return
  end

  local bin = herdr_bin()
  if bin == nil then
    vim.notify(
      "herdr-nav: no usable herdr binary (stale HERDR_BIN_PATH and herdr not on PATH)",
      vim.log.levels.ERROR
    )
    return
  end

  -- Target this pane explicitly: `--current` resolves to the server's globally
  -- focused pane, which is not necessarily the pane we are running in.
  local out = vim.fn.system({ bin, "pane", "focus", "--direction", dir, "--pane", pane })
  if vim.v.shell_error ~= 0 then
    vim.notify(
      "herdr-nav: `herdr pane focus --direction " .. dir .. "` failed: " .. vim.trim(out),
      vim.log.levels.ERROR
    )
  end
end

function M.navigate(wincmd, dir)
  local prev = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. wincmd)
  if vim.api.nvim_get_current_win() ~= prev then
    return -- moved within Neovim
  end

  -- At a split edge: cross into the surrounding multiplexer.
  if vim.env.HERDR_PANE_ID and vim.env.HERDR_PANE_ID ~= "" then
    focus_herdr(dir)
  else
    local cmd = "TmuxNavigate" .. tmux_command[dir]
    if vim.env.TMUX and vim.env.TMUX ~= "" and vim.fn.exists(":" .. cmd) == 2 then
      pcall(vim.cmd, cmd)
    end
  end
end

local mappings = {
  { "<C-h>", "h", "left", "Navigate left (herdr/nvim)" },
  { "<C-j>", "j", "down", "Navigate down (herdr/nvim)" },
  { "<C-k>", "k", "up", "Navigate up (herdr/nvim)" },
  { "<C-l>", "l", "right", "Navigate right (herdr/nvim)" },
}

function M.setup()
  for _, m in ipairs(mappings) do
    vim.keymap.set("n", m[1], function()
      M.navigate(m[2], m[3])
    end, { silent = true, noremap = true, desc = m[4] })
  end
end

return M
