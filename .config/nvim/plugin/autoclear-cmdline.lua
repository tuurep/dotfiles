local function clear() vim.cmd("echo ''") end

vim.api.nvim_create_autocmd("CmdLineLeave", {
    callback = function()
        local seconds = 15
        vim.fn.timer_start(1000*seconds, clear)
    end
})
