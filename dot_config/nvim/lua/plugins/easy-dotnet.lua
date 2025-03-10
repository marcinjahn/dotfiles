return {
  "GustavEikaas/easy-dotnet.nvim",
  branch = "refactor/dotnet-new-sync-picker",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  opts = {
    picker = "telescope",
  },
  -- config = function()
  --   require("easy-dotnet").setup()
  -- end,
}
