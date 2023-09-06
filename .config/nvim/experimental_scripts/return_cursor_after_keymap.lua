-- Works, but would be nice if any movement during mapping was not visible

local function return_cursor_after(keymap)
    -- returns cursor to the position where mapping started
    local c = vim.api.nvim_win_get_cursor(0)
    vim.fn.feedkeys(keymap)
    vim.schedule(function()
        vim.api.nvim_win_set_cursor(0, c)
    end)
end
