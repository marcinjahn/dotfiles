return {
  {
    "mason-org/mason.nvim",

    opts = function(_, opts)
      -- opts.ensure_installed = opts.ensure_installed or {}
      -- table.insert(opts.ensure_installed, "deno")

      opts.registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      }
    end,
  },
}
