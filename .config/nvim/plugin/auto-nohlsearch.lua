-- Always turn off hlsearch as soon as possible
-- (next keypress after any search command /?nN*#)

-- No thought given to:
--    - operator-pending mode
--        - (turns hlsearch on)
--        - maybe ok
--    - `gn` `gN`
--        - (turns hlsearch off)
--        - hlsearch could be useful here...

local searchkeys = { "n", "N", "*", "#" }

vim.api.nvim_create_autocmd({"CursorMoved"}, {
    callback = function()

        if vim.v.hlsearch == 0 then
            return
        end

        vim.on_key(function(key)
            if not vim.tbl_contains(searchkeys, key) then
                vim.cmd.nohlsearch()
            end
        end)

    end
})
