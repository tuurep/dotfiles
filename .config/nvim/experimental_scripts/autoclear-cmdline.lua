-- TODO:
-- This only clears messages that are shown after doing something on command mode
--
-- How to clear any message, for example
--      y     - n lines yanked
--      u     - n changes; this and that
--      <C-r> - Already at newest change
--
-- ?

local timer = vim.loop.new_timer()
local timeout_sec = 15

local function clear_cmdline() vim.cmd("echo ''") end

vim.api.nvim_create_autocmd("CmdLineLeave", {
    callback = function()
        timer:stop()
        timer:start(1000*timeout_sec, 0, vim.schedule_wrap(clear_cmdline))
    end
})
