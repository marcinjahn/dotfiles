return {
  "echasnovski/mini.files",
  vscode = true,
  keys = {
    {
      "<leader>e",
      function()
        local plugin = require("mini.files")
        if #vim.api.nvim_list_bufs() == 0 then
          plugin.open(LazyVim.root(), true)
        else
          plugin.open(vim.api.nvim_buf_get_name(0), true)
        end
      end,
      desc = "Open mini.files (directory of current file)",
    },
    -- {
    --   "<leader>E",
    --   function()
    --     require("mini.files").open(vim.loop.cwd(), true)
    --   end,
    --   desc = "Open mini.files (cwd)",
    -- },
    {
      "<leader>fm",
      function()
        require("mini.files").open(LazyVim.root(), true)
      end,
      desc = "Open mini.files (root)",
    },
  },
  opts = {
    windows = {
      width_nofocus = 20,
      width_focus = 50,
      width_preview = 100,
    },
    options = {
      use_as_default_explorer = true,
    },
  },
}
