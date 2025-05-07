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

-- return {
--   "stevearc/conform.nvim",
--   optional = true,
--   opts = {
--     formatters_by_ft = {
--       cs = { "csharpier_local", "csharpier_global", stop_after_first = true },
--     },
--     formatters = {
--       csharpier_local = {
--         command = "dotnet",
--         args = { "csharpier", "--write-stdout" },
--         condition = function(ctx)
--           local util = require("conform.util")
--           -- Define patterns that indicate a project root relevant for local csharpier.
--           -- util.root_file returns a function that finds the directory containing one of these files.
--           local root_finder = util.root_file({
--             ".config/dotnet-tools.json", -- Primary indicator for dotnet local tools
--             ".sln", -- Solution file
--             ".csproj", -- C# project file
--             ".git", -- Git repository root
--           })
--           -- ctx.filename is the full path to the file being processed.
--           local project_root = root_finder(ctx, ctx.filename)
--
--           if not project_root then
--             -- If no relevant project root is found, this local formatter is not applicable.
--             return false
--           end
--
--           -- Options for the system call to check csharpier availability.
--           -- We want to run this check from the project root and suppress any output.
--           local cmd_opts = {
--             cwd = project_root,
--             stdout = vim.NIL, -- Discard standard output
--             stderr = vim.NIL, -- Discard standard error
--           }
--
--           -- Execute "dotnet csharpier --version" to check if it's callable.
--           -- A successful execution (exit code 0) means csharpier is available via dotnet.
--           local result = vim.system({ "dotnet", "csharpier", "--version" }, cmd_opts)
--           return result.code == 0
--         end,
--         cwd = function(ctx)
--           local util = require("conform.util")
--           local root_finder = util.root_file({
--             ".config/dotnet-tools.json",
--             ".sln",
--             ".csproj",
--             ".git",
--           })
--           -- ctx.bufname is typically used for the formatter's working directory.
--           local project_root = root_finder(ctx, ctx.bufname)
--           return project_root -- conform.nvim will use the file's directory if this returns nil
--         end,
--         -- cwd = function(a, ctx)
--         --   return require("conform.util").root_file(".csproj")(a, ctx)
--         -- end,
--         -- command = "dotnet",
--         -- args = { "csharpier", "--write-stdout" },
--       },
--       csharpier_global = {
--         command = "csharpier",
--         args = { "format", "--write-stdout" },
--       },
--     },
--   },
-- }
