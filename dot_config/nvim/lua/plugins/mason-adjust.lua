-- versions pinned due to breaking changes in V2.
-- Have to wait until LazyVim fixes arrive
return {
  {
    "mason-org/mason.nvim",
    version = "1.11.0", -- HACK to be removed
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    },
  },
  { "mason-org/mason-lspconfig.nvim", version = "1.32.0" }, -- HACK to be removed
}
