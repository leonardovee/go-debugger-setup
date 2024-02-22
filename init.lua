-- Setup the package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup the plugins
require("lazy").setup({
    "mfussenegger/nvim-dap",
    {
        "leoluz/nvim-dap-go",
        config = function()
            require("dap-go").setup()
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"]=function()
              dapui.open()
            end

            dap.listeners.before.event_terminated["dapui_config"]=function()
              dapui.close()
            end

            dap.listeners.before.event_exited["dapui_config"]=function()
              dapui.close()
            end
        end,
    }
})

-- Setup the keymaps
vim.keymap.set("n", "<leader>db", "<cmd>:DapContinue<CR>")
vim.keymap.set("n", "<leader>dq", "<cmd>:DapTerminate<CR>")
vim.keymap.set("n", "<leader>dt", "<cmd>:DapStepOut<CR>")
vim.keymap.set("n", "<leader>di", "<cmd>:DapStepInto<CR>")
vim.keymap.set("n", "<leader>dr", "<cmd>:DapToggleRepl<CR>")
vim.keymap.set("n", "<leader>dp", "<cmd>:DapToggleBreakpoint<CR>")

