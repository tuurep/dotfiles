-- Always turn off hlsearch as soon as possible
-- (next keypress after any search command /?nN*#)

-- No thought given to:
--    - `gn` `gN`
--        - (turns hlsearch off)
--        - hlsearch could be useful here...

-- Problems:
--    - after completing a substitute, shows searchhl
--      on every instance of the substituted string
--    - example: `:s/key/foo`
--
--    - operator-pending mode
--        - `dn` turns on hlsearch
--        - `dsxy` (sneak) doesn't turn on hl
--        - would prefer `dn` to act the same way
--          but may be not worth bothering about
--          (because I couldn't find out how)

local searchkeys = { "n", "N", "*", "#" }

vim.on_key(function(key)
    if vim.v.hlsearch == 1 then
        if not vim.tbl_contains(searchkeys, key) then
            vim.cmd.nohlsearch()
        end
    end
end)
