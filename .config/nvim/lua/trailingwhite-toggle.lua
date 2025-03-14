-- Toggle a highlight group to reveal trailing whitespace

-- Todo: add color to the SHOWN and HIDDEN messages
-- Todo: additionally add a vertical line on lines exceeding `textwidth` cols
--    -> change name e.g. `trailingwhite-toggle` -> `mistakes-hl-toggle`

local fg =  "#d0d0d0"
local red = "#c36060"

vim.api.nvim_set_hl(0, "TrailingWhitespace", { fg=fg, bg=red })

local matches = {}
local shown = false

local function enable_hl(window)
    if not matches[window] then
        matches[window] = vim.fn.matchadd("TrailingWhitespace", "\\s\\+$")
    end
end

local function toggle_trailing_whitespace()
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

return toggle_trailing_whitespace
