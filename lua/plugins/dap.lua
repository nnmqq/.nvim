---@diagnostic disable: undefined-field, missing-fields
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      lazy = true,
      opts = {
        icons = {
          expanded = "▾",
          collapsed = "▸",
          current_frame = "▸",
        },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        -- Use this to override mappings for specific elements
        element_mappings = {
          -- Example:
          -- stacks = {
          --   open = "<CR>",
          --   expand = "o",
          -- }
        },
        -- Expand lines larger than the window
        -- Requires >= 0.7
        expand_lines = vim.fn.has("nvim-0.7") == 1,
        -- Layouts define sections of the screen to place windows.
        -- The position can be "left", "right", "top" or "bottom".
        -- The size specifies the height/width depending on position. It can be an Int
        -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
        -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
        -- Elements are the elements shown in the layout (in order).
        -- Layouts are opened in order so that earlier layouts take priority in window sizing.
        layouts = {
          {
            elements = {
              -- Elements can be strings or table with id and size keys.
              { id = "scopes", size = 0.4 },
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40, -- 40 columns
            position = "left",
          },
          {
            elements = {
              "repl",
              -- "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
          },
        },
        controls = {
          -- Requires Neovim nightly (or 0.8 when released)
          enabled = true,
          -- Display controls in this element
          element = "repl",
          icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "",
          },
        },
        floating = {
          max_height = nil,  -- These can be integers or a float between 0 and 1.
          max_width = nil,   -- Floats will be treated as percentage of your screen.
          border = "single", -- Border style. Can be "single", "double" or "rounded"
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil, -- Can be integer or nil.
          max_value_lines = 100, -- Can be integer or nil.
        },
      },
      config = function(_, opts)
        local dapui = require("dapui")
        dapui.setup(opts)

        --TODO: lazy load dapui so dap is lazy loaded
        local dap = require("dap")
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
      end,
    },
    "williamboman/mason.nvim",
    "nvim-neotest/nvim-nio",
    "jay-babu/mason-nvim-dap.nvim",
    "julianolf/nvim-dap-lldb",
  },
  keys = function(_, keys)
    local dap = require("dap")
    local dapui = require("dapui")
    return {
      { "<F5>",       dap.continue,          desc = "Debug: Start/Continue" },
      { "<F10>",      dap.step_over,         desc = "Debug: Step Over" },
      { "<F11>",      dap.step_into,         desc = "Debug: Step Into" },
      { "<F12>",      dap.step_out,          desc = "Debug: Step Out" },
      { "<leader>db", dap.toggle_breakpoint, desc = "Debug: Toggle Breakpoint" },
      {
        "<leader>dB",
        function()
          dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Debug: Set Conditional Breakpoint",
      },
      { "<F7>", dapui.toggle, desc = "Debug: Toggle UI" },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require("dap")

    -- Set up Mason for auto-installing DAP components
    require("mason-nvim-dap").setup({
      automatic_installation = true,
      ensure_installed = { "cpptools" },
    })

    dap.adapters.lldb = {
      type = "executable",
      command = "/usr/bin/lldb-dap",           -- adjust as needed, must be absolute path
      name = "lldb",
    }

    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "-i", "dap" },
    }

    dap.configurations.cpp = {
      {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input(
            "Path to executable: ",
            vim.fn.getcwd() .. "/",
            "file"
          )
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      },
      {
        -- If you get an "Operation not permitted" error using this, try disabling YAMA:
        --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        name = "Attach to process",
        type = "cpp",             -- Adjust this to match your adapter name (`dap.adapters.<name>`)
        request = "attach",
        pid = require("dap.utils").pick_process,
        args = {},
      },
    }

    dap.configurations.c = dap.configurations.cpp

    dap.configurations.zig = {
      {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input(
            "Path to executable: ",
            vim.fn.getcwd() .. "/zig-out/bin/",
            "file"
          )
        end,
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
      },
    }
  end,
}
