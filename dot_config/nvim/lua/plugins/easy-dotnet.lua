return {
  {
    "GustavEikaas/easy-dotnet.nvim",
    -- branch = "feat/neotest",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      picker = "snacks",
      auto_bootstrap_namespace = {
        type = "file_scoped",
        use_clipboard_json = {
          behavior = "never",
        },
      },
      lsp = {
        enabled = false,
      },
    },
  },
}
