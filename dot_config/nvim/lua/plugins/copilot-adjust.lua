return {
  {
    "zbirenbaum/copilot.lua",
    vscode = false,
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
      },
    },
  },
  { "zbirenbaum/copilot-cmp", vscode = false, enabled = false },
}
