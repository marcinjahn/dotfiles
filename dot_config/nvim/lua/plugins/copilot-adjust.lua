return {
  {
    "zbirenbaum/copilot.lua",
    vscode = false,
    -- event = "InsertEnter",
    opts = {
      -- suggestion = {
      --   enabled = true,
      --   auto_trigger = true,
      --   keymap = {
      --     accept = "<M-l>", -- normally handled by nvim-cmp / blink.cmp
      --   },
      -- },
      copilot_node_command = vim.fn.expand("$HOME") .. "/.asdf/installs/nodejs/25.1.0/bin/node", -- Node.js version must be > 22
    },
  },
  -- { "zbirenbaum/copilot-cmp", vscode = false, enabled = false },
  -- { "giuxtaposition/blink-cmp-copilot", vscode = false, enabled = false },
}
