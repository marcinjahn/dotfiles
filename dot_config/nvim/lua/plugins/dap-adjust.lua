local function rebuild_project(co, path)
  local spinner = require("easy-dotnet.ui-modules.spinner").new()
  spinner:start_spinner("Building")
  vim.fn.jobstart(string.format("dotnet build %s", path), {
    on_exit = function(_, return_code)
      if return_code == 0 then
        spinner:stop_spinner("Built successfully")
      else
        spinner:stop_spinner("Build failed with exit code " .. return_code, vim.log.levels.ERROR)
        error("Build failed")
      end
      coroutine.resume(co)
    end,
  })
  coroutine.yield()
end

return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_instaled = {
        "coreclr",
        "js",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    enabled = true,
    config = function()
      local dap = require("dap")
      local dotnet = require("easy-dotnet")
      local dapui = require("dapui")
      dap.set_log_level("TRACE")

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, {})

      local function file_exists(path)
        local stat = vim.loop.fs_stat(path)
        return stat and stat.type == "file"
      end

      local debug_dll = nil

      local function ensure_dll()
        if debug_dll ~= nil then
          return debug_dll
        end
        local dll = dotnet.get_debug_dll()
        debug_dll = dll
        return dll
      end

      for _, value in ipairs({ "cs", "fsharp" }) do
        dap.configurations[value] = {
          {
            type = "coreclr",
            name = "Program",
            request = "launch",
            env = function()
              local dll = ensure_dll()
              local vars = dotnet.get_environment_variables(dll.project_name, dll.absolute_project_path)
              return vars or nil
            end,
            program = function()
              local dll = ensure_dll()
              local co = coroutine.running()
              rebuild_project(co, dll.project_path)
              if not file_exists(dll.target_path) then
                error("Project has not been built, path: " .. dll.target_path)
              end
              return dll.target_path
            end,
            cwd = function()
              local dll = ensure_dll()
              return dll.absolute_project_path
            end,
          },
        }

        dap.listeners.before["event_terminated"]["easy-dotnet"] = function()
          debug_dll = nil
        end

        dap.adapters.coreclr = {
          type = "executable",
          command = "netcoredbg",
          args = { "--interpreter=vscode" },
        }
      end
    end,
    keys = {
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
    },
    -- dependencies = {
    --   { "nvim-neotest/nvim-nio" },
    -- {
    --   "rcarriga/nvim-dap-ui",
    --   config = function()
    --     require("dapui").setup({
    --       icons = { expanded = "", collapsed = "", current_frame = "" },
    --       mappings = {
    --         expand = { "<CR>" },
    --         open = "o",
    --         remove = "d",
    --         edit = "e",
    --         repl = "r",
    --         toggle = "t",
    --       },
    --       element_mappings = {},
    --       expand_lines = true,
    --       force_buffers = true,
    --       layouts = {
    --         {
    --           elements = {
    --             { id = "scopes", size = 1 },
    --             -- {
    --             --   id = "repl",
    --             --   size = 0.66,
    --             -- },
    --           },
    --
    --           size = 10,
    --           position = "bottom",
    --         },
    --         {
    --           elements = {
    --             "breakpoints",
    --             -- "console",
    --             "stacks",
    --             "watches",
    --           },
    --           size = 45,
    --           position = "right",
    --         },
    --       },
    --       floating = {
    --         max_height = nil,
    --         max_width = nil,
    --         border = "single",
    --         mappings = {
    --           ["close"] = { "q", "<Esc>" },
    --         },
    --       },
    --       controls = {
    --         enabled = vim.fn.exists("+winbar") == 1,
    --         element = "repl",
    --         icons = {
    --           pause = "",
    --           play = "",
    --           step_into = "",
    --           step_over = "",
    --           step_out = "",
    --           step_back = "",
    --           run_last = "",
    --           terminate = "",
    --           disconnect = "",
    --         },
    --       },
    --       render = {
    --         max_type_length = nil, -- Can be integer or nil.
    --         max_value_lines = 100, -- Can be integer or nil.
    --         indent = 1,
    --       },
    --     })
    --   end,
    -- },
    -- },
  },
}
