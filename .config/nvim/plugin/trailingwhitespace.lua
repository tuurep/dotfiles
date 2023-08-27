-- Toggle a highlight group to reveal trailing whitespace

local fg = 7
local red = 1

vim.api.nvim_set_hl(0, "TrailingWhitespace", { ctermfg=fg, ctermbg=red })

local matches = {}
local shown = false

local function enable_hl(window)
    if not matches[window] then
        matches[window] = vim.fn.matchadd("TrailingWhitespace", "\\s\\+$")
    end
end

local function toggle()
    local wlist = vim.api.nvim_tabpage_list_wins(0)

    for _, w in ipairs(wlist) do
        vim.api.nvim_win_call(w, function()
            if not shown then
                enable_hl(w)
            else
                vim.fn.matchdelete(matches[w])
                matches[w] = nil
            end
        end)
    end

    shown = not shown
    vim.cmd("echo 'Trailing whitespace " .. (shown and "SHOWN" or "HIDDEN") .. "'")
end

vim.api.nvim_create_autocmd({"WinEnter"}, {
    callback = function()
        local new_win = vim.api.nvim_get_current_win()
        if shown then
            enable_hl(new_win)
        end
    end
})

local toggle_key = "ä"
vim.keymap.set("n", toggle_key, toggle)
