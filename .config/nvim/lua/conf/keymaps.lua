-- Shorthands
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local s = { silent = true }
local r = { remap = true }
local b = { buffer = 0 }

-- <leader> is <Space>
vim.keymap.set({"n", "x", "o"}, "<Space>", "<Nop>")
vim.g.mapleader = " "

-- Free keys:
map({"n", "x", "o"}, "<Up>", "<Nop>")
map({"n", "x", "o"}, "<Down>", "<Nop>")
map({"n", "x", "o"}, "+", "<Nop>")
map({"n", "x", "o"}, "M", "<Nop>")      -- H M L -> _ - Alt-
map({"n", "x", "o"}, "/", "<Nop>")      -- Tab/S-Tab as search, ? is now :help
map("n", "<C-r>", "<Nop>")              -- U as redo
map("n", "<C-o>", "<Nop>")              -- <C-i> is compromised so use <M-o> and <M-i>
map("n", "<C-h>", "<Nop>")
map("n", "<C-l>", "<Nop>")
map("n", "<C-e>", "<Nop>")              -- <M-j> and <M-k> are remapped as <C-e> and <C-y>
map({"n", "x"}, "<BS>", "<Nop>")

-- Free (but bad):
map({"n", "x", "i", "c"}, "<PageUp>", "<Nop>")
map({"n", "x", "i", "c"}, "<PageDown>", "<Nop>")
map({"n", "i"}, "<F1>", "<Nop>")

-- Prevent accidental invokings of macros
map({"n", "x"}, "Q", "q")
map({"n", "x"}, "q", "<Nop>")

-- The default Q is not bad but its default mapping is bad, here's a better alternative:
map("n", "<leader>@", "Q")

-- Tab to search because / sucks in Finnish layout
map({"n", "x", "o"}, "<Tab>", "/")
map({"n", "x", "o"}, "<S-Tab>", "?")

-- remap jumplist maps: <C-i> and <Tab> are the same due to terminal weirdness
map("n", "<M-o>", "<C-o>")
map("n", "<M-i>", "<C-i>")

-- Start a substitute command without finger gymnastics:
map("n", "<leader><Tab>", ":%s/")

map("n", "<leader><Enter>", function()
    local path = vim.fn.expand("%")
    local tildepath = vim.fn.fnamemodify(path, ":p:~")
    if vim.fn.bufname() == "" then
        tildepath = tildepath .. "[No Name]"
    end
    vim.api.nvim_echo({{tildepath}}, false, {})      -- current buffer full path
end)                                                 -- $HOME as ~

map("n", "<leader><leader><Enter>",
    ":echo fnamemodify(getcwd(), ':p:~')<cr>", s)    -- pwd but with tilde

map("n", "<Enter>", ":echo ''<cr>", s)               -- clear cmdline text

-- Can't do the above mapping for command line <C-f> special buffer
autocmd({"CmdWinEnter"}, {
    callback = function()
        map("n", "<Enter>", "<Enter>", b)
    end
})

-- Insert/command mode Ctrl+a for beginning of line, Ctrl+E for end of line (readline style)
-- If they override something, remap that elsewhere
map({"i", "c"}, "<C-a>", "<Home>")
map("i", "<C-e>", "<End>")
map({"i", "c"}, "<C-b>", "<C-a>") -- command mode: <C-b> == <Home>, insert mode: <C-b> is unmapped
map("i", "<M-i>", "<C-e>")

-- Comfortable movement keys:
map({"n", "x", "o"}, "<C-j>", "<C-d>")
map({"n", "x", "o"}, "<C-k>", "<C-u>")
map({"n", "x", "o"}, "H", "^")
map({"n", "x", "o"}, "J", "}")
map({"n", "x", "o"}, "K", "{")
map({"n", "x", "o"}, "L", "$")
map({"n", "x", "o"}, "gH", "g^")
map({"n", "x", "o"}, "gJ", "g}")
map({"n", "x", "o"}, "gK", "g{")
map({"n", "x", "o"}, "gL", "g$")
map("i", "<C-h>", "<Left>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-l>", "<Right>")
map("n", "<M-h>", "zh")
map("n", "<M-j>", "<C-e>")
map("n", "<M-k>", "<C-y>")
map("n", "<M-l>", "zl")
map("n", "<Left>", ":bp<cr>", s)
map("n", "<Right>", ":bn<cr>", s)

-- Remap what the above has overriden
map({"n", "x"}, "¤", "J")
map({"n", "x"}, "g¤", "gJ")
map({"i", "c"}, "<C-z>", "<C-k>")
map({"n", "x", "o"}, "_", "H")     -- underscore
map({"n", "x", "o"}, "-", "M")     -- dash
map({"n", "x", "o"}, "<M-->", "L") -- Alt + dash
map({"n", "x"}, "?", "K")

-- One-handed save and quit
map("n", "<C-s>", ":w<cr>", s)
map("n", "<C-q>", ":q<cr>", s)

-- Like dd yy but no newline at end (completely awesome)
map("n", "<C-y>", function()
    vim.fn.setreg(vim.v.register, vim.api.nvim_get_current_line())
end)
map("n", "<C-d>", '<C-y>0"_D', r) -- blackhole the deletion to not set unnamed reg
                                  -- if another reg was chosen

-- Append register to current line as a oneliner
map("n", "<C-p>", function()
    local line = vim.api.nvim_get_current_line()
    local reg = vim.fn.getreg(vim.v.register)

    if reg ~= "" then
        local joined = reg:gsub("\n$", ""):gsub("^%s*", ""):gsub("%s+", " ")
        if line ~= "" then
            line = line .. " "
        end
        vim.api.nvim_set_current_line(line .. joined)
    end
    vim.cmd.normal("$")
end)

-- Fix x and X (from being terrible)
-- To be fixed: would like consecutive xxxxxxx to be treated as a single undo item
-- (not simple)
local function blackhole(key)
    local c = vim.v.count
    if c > 0 then
        vim.cmd('normal! ' .. c .. key)
    else
        vim.cmd('normal! "_' .. key)
    end
end
map("n", "x", function() blackhole("x") end)
map("n", "X", function() blackhole("X") end)

-- o O normal mode companion
map("n", "ö", "o<Esc>")
map("n", "Ö", "O<Esc>")

-- Without shift = forward, with shift = backward
map({"n", "x"}, "<", ">")
map({"n", "x"}, ">", "<")
map("n", "<<", ">>")
map("n", ">>", "<<")
map({"n", "x", "o"}, ",", ";")
map({"n", "x", "o"}, ";", ",")

-- Undo follows the same idea as above
-- Map <M-u> to WeirdUndo so it's still available when you want to use it (never)
map("n", "U", "<C-r>")
map("n", "<M-u>", "U")

-- ~ too hard to press for being so useful
map("n", "å", "~")
map("n", "gå", "g~")
map("n", "gåå", "g~~")

-- See highlight group under cursor
map("n", "<leader>e", ":Inspect<cr>", s)

-- Bigger lua functions
map("n", "Å", require("trailingwhite-toggle"))
