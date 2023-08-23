-- If there are multiple splits open, list all visible buffers'
-- names in the WM titlebar

-- Example: "nvim main.js, todo.txt, index.html"

vim.o.title = true -- required so that titlestring can be set

local function is_normal_buffer(b)
    return vim.bo[b].buftype == ""
end

local function set_titlestring()
    local blist = vim.fn.tabpagebuflist()
    blist = vim.tbl_filter(is_normal_buffer, blist)

    local t = "nvim"

    for i, b in ipairs(blist) do
        local name = vim.fn.bufname(b)
        name = vim.fn.fnamemodify(name, ":t") -- remove full path (filename only)

        t = t .. " "

        if name == "" then
            t = t .. "[No Name]"
        else
            t = t .. name
        end

        local r = vim.bo[b].readonly
        local m = vim.bo[b].modified

        if r or m then
            t = t .. " "
                  .. (r and "[RO]" or "")
                  .. (m and "[+]"  or "")
        end

        -- Add separator, unless last element
        if i ~= #blist then
            t = t .. ","
        end
    end

    vim.o.titlestring = t
end

-- TODO:
--      Order of buffernames should change when swapping positions of splits (without resizing any)
--      I couldn't find a suitable event for now
--
vim.api.nvim_create_autocmd({"BufEnter", "WinResized", "BufModifiedSet"}, {
    callback = set_titlestring
})
