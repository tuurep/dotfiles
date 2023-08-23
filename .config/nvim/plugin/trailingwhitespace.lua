-- Toggle a highlight group to reveal trailing whitespace

local fg = 7
local red = 1

vim.api.nvim_set_hl(0, "TrailingWhitespace", { ctermfg=fg, ctermbg=red })

local toggle_key = "ä"
local shown = nil

local function toggle()
    if not shown then
        print("Trailing whitespace SHOWN")
        shown = vim.fn.matchadd("TrailingWhitespace", "\\s\\+$")
    else
        print("Trailing whitespace HIDDEN")
        vim.fn.matchdelete(shown)
        shown = nil
    end
end

vim.keymap.set('n', toggle_key, toggle)
