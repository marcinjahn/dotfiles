return {
  {
    "zerochae/endpoint.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = { "Endpoint", "EndpointRefresh" },
    config = function()
      require("endpoint").setup()
    end,
  },
}
