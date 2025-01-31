-- 1. Always turn off hlsearch as soon as possible
-- 2. Always center current search match (note: not sneak)

local save_scrolloff = vim.o.scrolloff

-- hlsearch: don't consider keypresses (of 'n' mostly) when using sneak's s/f/t
local was_sneak_input = false

vim.api.nvim_create_autocmd("User", {
    pattern = "SneakEnter",
    callback = function()
        was_sneak_input = true
    end
})
vim.api.nvim_create_autocmd("User", {
    pattern = "SneakLeave",
    callback = function()
        was_sneak_input = false 
    end
})

-- Idea:
-- https://www.reddit.com/r/neovim/comments/zc720y/comment/iyvcdf0/?utm_source=share&utm_medium=web2x&context=3
vim.on_key(function(char)

    if was_sneak_input then
        return
    end

    local mode = vim.api.nvim_get_mode().mode

    -- Todo: Surely there's a better way to check "if I'm in Normal or Visual mode"?

    -- Todo: During visual mode searches, hlsearch doesn't flip during the incsearch phase
    --       *unless* I type characters like 'n' in the search itself
    --       Why is this different with normal mode?

    if mode == "n" or mode == "v" or mode == "V" or mode == "" then

        local new_hlsearch = vim.tbl_contains(
            { "<CR>", "n", "N", "*", "#", "?", "/" },
            vim.fn.keytrans(char)
        )

        if vim.o.hlsearch ~= new_hlsearch then
            -- Keep view centered while searching
            if (new_hlsearch) then
                vim.o.scrolloff = 999
            else
                vim.o.scrolloff = save_scrolloff
            end

            vim.o.hlsearch = new_hlsearch
        end
    end
end)
