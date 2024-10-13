return {
  "nvim-neo-tree/neo-tree.nvim",
  vscode = false,
  keys = {

    { "<leader>e", false },
  },
  opts = {
    window = { position = "right" },
  },
}

-- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Visual-Customizations#hide-cursor-in-neo-tree-window
-- return {
-- {
--   "nvim-neo-tree/neo-tree.nvim",
--   opts = {
--     event_handlers = {
--       {
--         event = "neo_tree_buffer_enter",
--         handler = function()
--           -- This effectively hides the cursor
--           vim.cmd("highlight! Cursor blend=100")
--         end,
--       },
--       {
--         event = "neo_tree_buffer_leave",
--         handler = function()
--           -- Make this whatever your current Cursor highlight group is.
--           vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
--         end,
--       },
--     },
--   },
-- },
-- }
