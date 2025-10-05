return {
  {
    "folke/noice.nvim",
    vscode = false,
    opts = {
      presets = {
        lsp_doc_border = true,
      },
      lsp = {
        progress = {
          enabled = false, -- because of Roslyn (https://github.com/dotnet/roslyn/issues/79939)
        },
      },
    },
  },
}
