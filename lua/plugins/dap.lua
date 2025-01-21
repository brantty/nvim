local u = require("util")
local c = u.create_cmd
local m = u.lazy_map
local f = require("util.functions")

return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      m("<F1>", [[DapStepInto]]),
      m("<F2>", [[DapStepOver]]),
      m("<F3>", [[DapStepOut]]),
      m("<F4>", [[DapStepBack]]),
      m("<F5>", [[DapContinue]]),
      m("<F11>", [[DapRestartFrame]]),
      m("<F12>", [[DapDisconnect]]),
    },
    init = function()
      c("DapClearBreakpoints", require("dap").clear_breakpoints)
      c("DapConditionalBreakpoints", function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end)
    end,
    cmd = { "DapClearBreakpoints", "DapConditionalBreakpoints" },
    config = function()
      local dap, widgets = require("dap"), require("dap.ui.widgets")
      local sb_bufnr
      dap.listeners.before.launch.dapui_config = function()
        sb_bufnr = widgets.sidebar(widgets.scopes, { width = 50 }).open()
        dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
        dap.defaults.fallback.focus_terminal = true
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        vim.api.nvim_buf_delete(sb_bufnr, { force = true })
      end

      local function get_install_path(package)
        return require("mason-registry").get_package(package):get_install_path()
      end

      -- Go
      if not dap.adapters.go then
        dap.adapters.go = {
          type = "executable",
          command = "node",
          args = { get_install_path("go-debug-adapter") .. "/extension/dist/debugAdapter.js" },
        }
        dap.configurations.go = {
          {
            type = "go",
            name = "Debug current file",
            request = "launch",
            showLog = true,
            program = "${file}",
            dlvToolPath = vim.fn.exepath("dlv"),
          },
          -- {
          --   type = "go",
          --   name = "Debug test", -- configuration for debugging test files
          --   request = "launch",
          --   mode = "test",
          --   program = "${file}",
          --   dlvToolPath = vim.fn.exepath("dlv"),
          -- },
          -- -- works with go.mod packages and sub packages
          -- {
          --   type = "go",
          --   name = "Debug test (go.mod)",
          --   request = "launch",
          --   mode = "test",
          --   program = "./${relativeFileDirname}",
          -- },
        }
      end

      -- javascript/typescript
      if not dap.adapters["pwa-chrome"] then
        dap.adapters["pwa-chrome"] = {
          type = "server",
          host = "127.0.0.1",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              get_install_path("js-debug-adapter") .. "/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }
      end
      for _, lang in ipairs({
        "typescript",
        "javascript",
      }) do
        dap.configurations[lang] = dap.configurations[lang] or {}
        table.insert(dap.configurations[lang], {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch Chrome",
          url = "http://127.0.0.1:4200",
          sourceMaps = false,
        })
      end

      -- lua
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        },
      }
      dap.adapters.nlua = function(callback, config)
        ---@diagnostic disable-next-line: undefined-field
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
      end

      c("DapReplOpenTab", function()
        if dap.session() ~= nil then
          f.tab_cb(dap.repl.toggle)
        end
      end)
      c("DapReplOpenVSplit", function()
        if dap.session() ~= nil then
          dap.repl.toggle({}, "vsplit")
        end
      end)

      vim.keymap.set("n", "<leader>ds", function()
        widgets.cursor_float(widgets.scopes, { border = "rounded" })
      end, { noremap = true })
      vim.keymap.set("n", "<leader>du", function()
        widgets.cursor_float(widgets.frames, { border = "rounded" })
      end, { noremap = true })
      vim.keymap.set("n", "<leader>dt", function()
        widgets.cursor_float(widgets.threads, { border = "rounded" })
      end, { noremap = true })
      vim.keymap.set("n", "<leader>dr", "<cmd>DapReplOpenTab<cr>", { noremap = true })
      vim.keymap.set("n", "<leader>dv", "<cmd>DapReplOpenVSplit<cr>", { noremap = true })
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "BufReadPre",
  },
  {
    "ofirgall/goto-breakpoints.nvim",
    event = "BufReadPre",
    keys = {
      m("]r", [[lua require('goto-breakpoints').next()]]),
      m("[r", [[lua require('goto-breakpoints').prev()]]),
    },
    dependencies = "mfussenegger/nvim-dap",
  },
  {
    "Weissle/persistent-breakpoints.nvim",
    event = "BufReadPre",
    opts = {
      load_breakpoints_event = { "BufReadPost" },
    },
    keys = {
      m("<leader>/", [[lua require('persistent-breakpoints.api').toggle_breakpoint()]]),
    },
    dependencies = "mfussenegger/nvim-dap",
  },
  "jbyuki/one-small-step-for-vimkind",
}
