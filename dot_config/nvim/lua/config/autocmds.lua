-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Refresh CodeLens automatically
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
  callback = function()
    vim.lsp.codelens.refresh({ bufnr = 0 })
  end,
})
-- better looking code lens
vim.api.nvim_set_hl(0, "LspCodeLens", { fg = "#717171", italic = true })
