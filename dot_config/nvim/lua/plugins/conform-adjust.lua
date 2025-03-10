return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      cs = { "csharpier" },
    },
    formatters = {
      csharpier = {
        -- cwd = function(a, ctx)
        --   return require("conform.util").root_file(".csproj")(a, ctx)
        -- end,
        command = "dotnet",
        args = { "csharpier", "--write-stdout" },
      },
    },
  },
}
