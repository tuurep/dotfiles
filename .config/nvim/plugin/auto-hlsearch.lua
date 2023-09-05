-- https://www.reddit.com/r/neovim/comments/zc720y/comment/iyvcdf0/?utm_source=share&utm_medium=web2x&context=3

vim.on_key(function(char)
    if vim.fn.mode() == "n" then
        local new_hlsearch = vim.tbl_contains(
            { "<CR>", "n", "N", "*", "#", "?", "/" },
            vim.fn.keytrans(char)
        )
        if vim.o.hlsearch ~= new_hlsearch then
            vim.o.hlsearch = new_hlsearch
        end
    end
end)
