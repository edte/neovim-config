-- lvim.builtin.dap.active = true

-- 配置 dap 调试
-- local dap = try_require("dap")
-- dap.adapters.cppdbg = {
--     id = "cppdbg",
--     type = 'executable',
--     command = "/home/edte/.local/share/nvim/mason/bin/OpenDebugAD7",
-- }

-- dap.configurations.cpp = {
--     {
--         name = "Launch file",
--         type = "cppdbg",
--         request = "launch",
--         program = function()
--             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--         end,
--         -- args = function()
--         --     local input = vim.fn.input("Input args: ")
--         -- end,
--         cwd = '${workspaceFolder}',
--         stopOnEntry = true,
--         setupCommands = {
--             {
--                 description = 'enable pretty printing',
--                 text = '-enable-pretty-printing',
--                 ignoreFailures = false
--             },
--         },
--     }
-- }


-- dap.configurations.c = dap.configurations.cpp

-- try_require("nvim-dap-virtual-text").setup {
--     enabled = true,                     -- enable this plugin (the default)
--     enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
--     highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
--     highlight_new_as_changed = true,    -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
--     show_stop_reason = true,            -- show stop reason when stopped for exceptions
--     commented = false,                  -- prefix virtual text with comment string
--     -- experimental features:
--     virt_text_pos = 'eol',              -- position of virtual text, see `:h nvim_buf_set_extmark()`
--     all_frames = false,                 -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
--     virt_lines = false,                 -- show virtual lines instead of virtual text (will flicker!)
--     virt_text_win_col = nil             -- position the virtual text at a fixed window column (starting from the first text column) ,
--     -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
-- }

-- 打断点
-- map("n", "bb", "<cmd>lua try_require'dap'.toggle_breakpoint()<cr>", {})
-- map("n", "bc", "<cmd>lua try_require'dap'.continue()<cr>", {})
-- map("n", "bo", "<cmd>lua try_require'dap'.step_over()<cr>", {})
-- map("n", "bi", "<cmd>lua try_require'dap'.step_into()<cr>", {})
