return {
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        mux = {
          backend = "zellij",
          enabled = false,
        },
      },
    },
    -- keys = {
    --   {
    --     "<leader>af",
    --     function()
    --       require("sidekick.cli").send({ msg = "{file}" })
    --     end,
    --     desc = "Send File",
    --   },
    --   {
    --     "<leader>ac",
    --     function()
    --       require("sidekick.cli").toggle({ name = "claude", focus = true })
    --     end,
    --     desc = "Sidekick Claude Toggle",
    --     mode = { "n", "v" },
    --   },
    -- },
  },
}
