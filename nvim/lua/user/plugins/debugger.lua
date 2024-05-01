return {
    'rcarriga/nvim-dap-ui',
    dependencies = {
        'mfussenegger/nvim-dap',
        'nvim-neotest/nvim-nio',
    },
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')
        require("dapui").setup()
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
        vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {});
        vim.keymap.set("n", "<Leader>dc", dap.continue, {});
        dap.adapters.lldb = {
            type = 'executable',
            command = 'C:/Program Files/LLVM/bin/lldb-dap', -- adjust as needed, must be absolute path
            name = 'lldb'
        }

        dap.configurations.zig = {
            {
                name = 'Launch',
                type = 'lldb',
                request = 'launch',
                program = '${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}.exe',
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},

                -- 💀
                -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
                --
                --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
                --
                -- Otherwise you might get the following error:
                --
                --    Error on launch: Failed to attach to the target process
                --
                -- But you should be aware of the implications:
                -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
                -- runInTerminal = false,
            },
        }
    end
}
