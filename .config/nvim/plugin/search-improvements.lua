-- https://www.reddit.com/r/neovim/comments/zc720y/comment/iyvcdf0/?utm_source=share&utm_medium=web2x&context=3

vim.on_key(function(char)
    if vim.fn.mode() == "n" --[[ Todo: visual mode(s) not considered? ]] then

        local new_hlsearch = vim.tbl_contains(
            { "<CR>", "n", "N", "*", "#", "?", "/" },
            vim.fn.keytrans(char)
        )

        if vim.o.hlsearch ~= new_hlsearch then
            -- Keep view centered while searching
            if (new_hlsearch) then
                vim.o.scrolloff = 999
            else
                vim.o.scrolloff = 0
            end

            vim.o.hlsearch = new_hlsearch
        end
    end
end)
