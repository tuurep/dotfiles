-- Always turn off hlsearch as soon as possible
-- (next keypress after any search command /?nN*#)

-- No thought given to:
--    - operator-pending mode
--        - (turns hlsearch on)
--        - maybe ok
--    - `gn` `gN`
--        - (turns hlsearch off)
--        - hlsearch could be useful here...

-- Todo:
--    - after completing a substitute, shows searchhl
--      on every instance of the substituted string
--    - example: `:s/key/foo`

local searchkeys = { "n", "N", "*", "#" }

vim.on_key(function(key)
    if vim.v.hlsearch == 1 then
        if not vim.tbl_contains(searchkeys, key) then
            vim.cmd.nohlsearch()
        end
    end
end)
