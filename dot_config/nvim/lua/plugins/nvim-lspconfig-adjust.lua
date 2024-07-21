-- return {
--   "neovim/nvim-lspconfig",
--   opts = {
--     servers = {
--       omnisharp = { enabled = false },
--       chsarp_ls = {
--         handlers = {
--           ["textDocument/definition"] = function(...)
--             return require("csharpls_extended").handler(...)
--           end,
--           ["textDocument/typeDefinition"] = function(...)
--             return require("csharpls_extended").handler(...)
--           end,
--         },
--       },
--     },
--   },
-- }
--
local util = require("lspconfig.util")

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      omnisharp = {
        enabled = false,
        handlers = {
          ["textDocument/definition"] = function(...)
            return require("omnisharp_extended").definition_handler(...)
          end,
          ["textDocument/references"] = function(...)
            return require("omnisharp_extended").references_handler(...)
          end,
          ["textDocument/implementation"] = function(...)
            return require("omnisharp_extended").implementation_handler(...)
          end,
        },
        keys = {
          {
            "gd",
            function()
              require("omnisharp_extended").telescope_lsp_definitions()
            end,
            desc = "Goto Definition",
          },
          {
            "gr",
            function()
              require("omnisharp_extended").telescope_lsp_references()
            end,
            desc = "References",
          },
          {
            "gI",
            function()
              require("omnisharp_extended").telescope_lsp_implementation()
            end,
            desc = "Goto Implementation",
          },
        },
        enable_roslyn_analyzers = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
      },
      angularls = {
        root_dir = util.root_pattern("angular.json", "project.json"),
      },
    },
  },
}
