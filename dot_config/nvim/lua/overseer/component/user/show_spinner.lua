return {
  desc = "Show Spinner",
  -- Define parameters that can be passed in to the component
  -- The params passed in will match the params defined above
  constructor = function(params)
    local num = 0
    local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

    local notification = vim.notify(spinner_frames[1] .. " Building", "info", {
      timeout = false,
    })

    local timer = vim.loop.new_timer()

    return {
      on_init = function(self, task)
        timer:start(
          100,
          100,
          vim.schedule_wrap(function()
            num = num + 1
            local new_spinner = num % #spinner_frames
            notification =
              vim.notify(spinner_frames[new_spinner + 1] .. " Building", "info", { replace = notification })
          end)
        )
      end,
      on_complete = function(self, task, code)
        vim.notify("", "info", { replace = notification, timeout = 1 })
        timer:stop()
        return code
      end,
    }
  end,
}
