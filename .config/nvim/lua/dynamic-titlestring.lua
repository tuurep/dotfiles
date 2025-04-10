-- If there are multiple splits open, list all visible buffers'
-- names in the WM titlebar

-- Example: "nvim main.js, todo.txt, stuff/"

vim.o.title = true -- required so that titlestring can be set

local function is_buf(b)
    return vim.bo[b].buftype == ""
end

local function is_dir(b)
    return vim.bo[b].filetype == "dirvish"
end

local function is_buf_or_dir(b)
    return is_buf(b) or is_dir(b)
end

local function append_dir(name, title)
    local home = vim.fn.expand("$HOME")

    -- At the root of user's home
    if name:match("^" .. home .. "/$") then
        return title .. "~/"
    end

    -- Last directory in path with trailing /
    name = name:match("[^/]*/$")

    return title .. name
end

local function append_buf(name, title)
    name = vim.fn.fnamemodify(name, ":t")

    if name == "" then
        return title .. "[No Name]"
    else
        return title .. name
    end
end

local function set_titlestring()
    local t = "nvim"

    local blist = vim.fn.tabpagebuflist()
    blist = vim.tbl_filter(is_buf_or_dir, blist)

    for i, b in ipairs(blist) do
        local name = vim.fn.bufname(b)

        t = t .. " "

        if is_dir(b) then
            t = append_dir(name, t)
        else
            t = append_buf(name, t)
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
