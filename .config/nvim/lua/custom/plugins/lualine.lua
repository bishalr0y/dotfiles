return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local harpoon = require("harpoon")

      local function harpoon_component()
        local list = harpoon:list()
        local total_marks = #list.items

        if total_marks == 0 then
          return ""
        end

        local current_mark = "—"
        local mark_idx = nil

        -- Get the current buffer's file path
        local current_file = vim.api.nvim_buf_get_name(0)
        if current_file == "" then
          return string.format("󰛢 %s/%d", current_mark, total_marks)
        end

        -- Normalize paths to handle absolute vs. relative paths
        local function normalize_path(path)
          return vim.fn.fnamemodify(path, ":p") -- Convert to full absolute path
        end

        current_file = normalize_path(current_file)

        -- Find the current file in the Harpoon list
        for i, item in ipairs(list.items) do
          local item_path = normalize_path(item.value)
          if item_path == current_file then
            mark_idx = i
            break
          end
        end

        if mark_idx ~= nil then
          current_mark = tostring(mark_idx)
        end

        return string.format("󰛢 %s/%d", current_mark, total_marks)
      end

      require("lualine").setup({
        options = {
          theme = "auto",
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "█", right = "█" },
        },
        sections = {
          lualine_b = {
            { "branch", icon = "" },
            harpoon_component,
            "diff",
            "diagnostics",
          },
          lualine_c = {
            { "filename", path = 1 },
          },
          lualine_x = {
            "filetype",
          },
        },
      })
    end,
  },
}
