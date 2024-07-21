return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-jest",
    "Issafalcon/neotest-dotnet",
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
      ["neotest-dotnet"] = {
        discovery_root = "solution",
      },
    },
  },
}
