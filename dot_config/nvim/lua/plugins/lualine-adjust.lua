-- local easy_dotnet_job_indicator = { require("easy-dotnet.ui-modules.jobs").lualine }

return {
  {
    "nvim-lualine/lualine.nvim",
    vscode = false,
    opts = function(_, opts)
      opts.sections.lualine_z = {} -- hides the clock
      -- opts.sections.lualine_a = { "mode", easy_dotnet_job_indicator }
    end,
  },
}
