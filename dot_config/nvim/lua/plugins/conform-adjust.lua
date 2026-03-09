return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
        csproj = { "csharpier" },
        sln = { "csharpier" },
        slnx = { "csharpier" },
        typescript = { "prettier", lsp_format = "last" },
        typescriptreact = { "prettier", lsp_format = "last" },
        javascript = { "prettier", lsp_format = "last" },
        javascriptreact = { "prettier", lsp_format = "last" },
      },
    },
  },
}
