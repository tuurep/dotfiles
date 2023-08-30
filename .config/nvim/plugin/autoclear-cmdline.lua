-- This makes any message in cmdline clear out after some idle time
-- If you missed something you need to see, run :mes[sages]

local timeout_sec = 4
vim.o.updatetime = 1000 * timeout_sec

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.cmd("echo ''")
    end
})
