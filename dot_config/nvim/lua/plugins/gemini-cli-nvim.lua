return {
  {
    "marcinjahn/gemini-cli.nvim",
    cmd = "Gemini",
    opts = {
      gemini_cmd = "ai",
    },
    keys = {
      { "<leader>a/", "<cmd>Gemini toggle<cr>", desc = "Toggle Gemini" },
      { "<leader>aa", "<cmd>Gemini ask<cr>", desc = "Ask Gemini", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>Gemini command<cr>", desc = "Gemini Commands" },
      { "<leader>ab", "<cmd>Gemini buffer<cr>", desc = "Send Buffer" },
      { "<leader>af", "<cmd>Gemini add_file<cr>", desc = "Add File" },
    },
    config = true,
  },
}
