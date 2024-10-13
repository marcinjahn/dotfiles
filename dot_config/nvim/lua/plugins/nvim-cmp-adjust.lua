return {
  {
    "hrsh7th/nvim-cmp",
    vscode = false,
    opts = function(_, opts)
      -- LSP borders (causes some errors)
      -- local float = { focusable = true, style = "minimal", border = "rounded" }
      -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
      -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)

      local cmp_window = require("cmp.config.window")

      opts.window = {
        completion = cmp_window.bordered(),
        documentation = cmp_window.bordered(),
      }
    end,
  },
}
