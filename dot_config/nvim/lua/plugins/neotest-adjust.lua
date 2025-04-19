return {
  "nvim-neotest/neotest",
  vscode = false,
  dependencies = {
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
    -- "Issafalcon/neotest-dotnet",
  },
  opts = {
    adapters = {
      ["neotest-jest"] = {
        jestCommand = "npm test --",
        jestConfigFile = "custom.jest.config.ts",
        -- env = { CI = true },
        cwd = function(path)
          return vim.fn.getcwd()
        end,
      },
      ["neotest-vitest"] = {},
      -- ["neotest-dotnet"] = {
      --   discovery_root = "solution",
      -- },
    },
  },
}
