-- If there are multiple splits open, list all visible buffers'
-- names in the WM titlebar

-- Example: "nvim main.js, todo.txt, index.html"

vim.o.title = true -- required so that titlestring can be set

local function set_titlestring()
    local blist = vim.fn.tabpagebuflist()
    local t = "nvim "

    if #blist < 2 then
        vim.o.titlestring = t .. "%t %m"
        return
    end

    for i, b in ipairs(blist) do
        local name = vim.fn.bufname(b)
        name = vim.fn.fnamemodify(name, ":t") -- remove full path (filename only)

        if name == "" then
            t = t .. "[No Name]"
        else
            t = t .. name
        end

        -- add separator, unless last element
        if i ~= #blist then
            t = t .. ", "
        end
    end

    vim.o.titlestring = t
end

-- TODO:
--      Order of buffernames should change when swapping positions of splits (without resizing any)
--      I couldn't find a suitable event for now
--
vim.api.nvim_create_autocmd({"BufEnter", "WinResized"}, {
    callback = set_titlestring
})
