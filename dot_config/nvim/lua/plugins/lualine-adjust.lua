return {
  {
    "nvim-lualine/lualine.nvim",
    vscode = false,
    opts = function(_, opts)
      opts.sections.lualine_z = {}
    end,
  },
}
