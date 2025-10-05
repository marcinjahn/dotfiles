return {
  {
    "folke/sidekick.nvim",
    keys = {
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle({ name = "claude", focus = true })
        end,
        desc = "Sidekick Claude Toggle",
        mode = { "n", "v" },
      },
    },
  },
}
