return {
  {
    "seblj/roslyn.nvim",
    -- commit = "76d4ddb8b5ec800c5d129c0bee5ab0d5ae8fff7f",
    ft = "cs",
    config = function()
      require("roslyn").setup({
        capabilities = nil,
      })
    end,
  },
}
