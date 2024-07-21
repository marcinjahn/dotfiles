return {
  {
    "folke/edgy.nvim",
    opts = function(_, opts)
      opts.keys = {
        -- increase width
        ["<c-Right>"] = function(win)
          win:resize("width", 30)
        end,
        -- decrease width
        ["<c-Left>"] = function(win)
          win:resize("width", -30)
        end,
        -- increase height
        ["<c-Up>"] = function(win)
          win:resize("height", 20)
        end,
        -- decrease height
        ["<c-Down>"] = function(win)
          win:resize("height", -20)
        end,
      }
    end,
  },
}
