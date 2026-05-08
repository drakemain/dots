return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  keys = {
    { "<F5>",        function() require('dap').continue() end,                                                desc = "Debug: Continue" },
    { "<F10>",       function() require('dap').step_over() end,                                               desc = "Debug: Step Over" },
    { "<F11>",       function() require('dap').step_into() end,                                               desc = "Debug: Step Into" },
    { "<F12>",       function() require('dap').step_out() end,                                                desc = "Debug: Step Out" },
    { "<leader>db",  function() require('dap').toggle_breakpoint() end,                                      desc = "Debug: Toggle Breakpoint" },
    { "<leader>dB",  function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,   desc = "Debug: Conditional Breakpoint" },
    { "<leader>dr",  function() require('dap').repl.open() end,                                              desc = "Debug: Open REPL" },
    { "<leader>dl",  function() require('dap').run_last() end,                                               desc = "Debug: Run Last" },
    { "<leader>du",  function() require('dapui').toggle() end,                                               desc = "Debug: Toggle UI" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"]    = function() dapui.close() end
  end,
}
