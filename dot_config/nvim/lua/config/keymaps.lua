-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set("n", "\\", "<C-w>", {
--   desc = "Show Window menu",
--   remap = true,
-- })

-- Delete single character without yanking
vim.keymap.set("n", "x", '"_x', { desc = "Delete char without yanking" })

-- Paths copying
local function copy_path_with_line(expansion)
  local path = vim.fn.expand(expansion)
  local mode = vim.fn.mode()
  local lines
  if mode == "v" or mode == "V" or mode == "\22" then
    local start_line = vim.fn.line("v")
    local end_line = vim.fn.line(".")
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
    lines = start_line == end_line and tostring(start_line) or (start_line .. "-" .. end_line)
    vim.api.nvim_input("<Esc>")
  else
    lines = tostring(vim.fn.line("."))
  end
  local result = path .. ":" .. lines
  vim.fn.setreg("+", result)
  vim.notify("Copied: " .. result)
end

vim.keymap.set("n", "<leader>bC", "<cmd>CopyAbsolutePath<cr>", { desc = "Copy absolute path" })
vim.keymap.set({ "n", "x" }, "<leader>bT", function()
  copy_path_with_line("%:p")
end, { desc = "Copy absolute path with line" })
vim.keymap.set("n", "<leader>bc", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy relative path" })
vim.keymap.set({ "n", "x" }, "<leader>bt", function()
  copy_path_with_line("%:.")
end, { desc = "Copy relative path with line" })
