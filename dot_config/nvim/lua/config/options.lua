-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.pumblend = 0
vim.opt.textwidth = 100
vim.o.mousemoveevent = true

-- https://github.com/swaits/zellij-nav.nvim
-- vim.api.nvim_create_autocmd("VimLeave", {
--   pattern = "*",
--   command = "silent !zellij action switch-mode normal",
-- })

vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

-- vim.api.nvim_add_user_command("CopyPath", "call setreg('+', expand('%'))", {})
vim.api.nvim_create_user_command("CopyAbsolutePath", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, {})

vim.api.nvim_create_user_command("CopyRelativePath", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
end, {})

vim.api.nvim_create_user_command("CopyFileName", function()
  vim.fn.setreg("+", vim.fn.expand("%:t"))
end, {})

-- This introduces a lof of noise, but it's an option
-- vim.diagnostic.config({
-- virtual_lines = false,
--
--   -- Alternatively, customize specific options
--   -- virtual_lines = {
--   --  -- Only show virtual line diagnostics for the current cursor line
--   --  current_line = true,
--   -- },
-- })
