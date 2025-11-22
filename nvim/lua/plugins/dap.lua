-- Debugging (DAP) Plugins
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      { "<F5>", desc = "Debug: Continue" },
      { "<F10>", desc = "Debug: Step Over" },
      { "<F11>", desc = "Debug: Step Into" },
      { "<F12>", desc = "Debug: Step Out" },
      { "<leader>db", desc = "Debug: Toggle Breakpoint" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb", "cppdbg" },
        automatic_installation = true,
      })

      dapui.setup()

      -- Auto-open/close DAP UI
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
}
