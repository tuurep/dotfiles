-- shorthands
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local s = {silent=true}
local r = {remap=true}

-- <leader> is <Space>
map("n", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- Disable keys that:
--   1. can interfere with other settings
--   2. I want to repurpose later
--   3. are annoying
map("n", "<Up>", "<Nop>")
map("n", "<Down>", "<Nop>")
map("n", "M", "<Nop>")
map("n", "+", "<Nop>")
map("n", "<C-o>", "<Nop>")
map("n", "<C-h>", "<Nop>")
map("n", "<C-l>", "<Nop>")
map("n", "<C-e>", "<Nop>") -- <M-j> and <M-k> are remapped as <C-e> and <C-y>
map({"n", "x"}, "<BS>", "<Nop>")
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

local function echo_fullpath_with_tilde()
    vim.cmd("echo substitute(expand('%:p'), $HOME, '~', '')")
end

map("n", "<leader><Enter>", echo_fullpath_with_tilde)
map("n", "<Enter>", ":echo ''<cr>", s) -- clear cmdline text

-- Can't do the above mapping for command line <C-f> special buffer
autocmd({"CmdWinEnter"}, {
    callback = function()
        map("n", "<Enter>", "<Enter>", {buffer=0})
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
map("n", "g/", "K")
map("n", "_", "H")
map("n", "<M-->", "M")
map("n", "-", "L")

-- One-handed save and quit
map("n", "<C-s>", ":w<cr>", s)
map("n", "<C-q>", ":q<cr>", s)
map("i", "<C-s>", "<C-o>:w<cr>", s)
map("i", "<C-q>", "<C-o>:q<cr>", s)

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

-- Mappings to Lua modules
local tws = require("trailingwhitespace")
map("n", "Å", tws.toggle_trailing_whitespace)

-- === PLUGINS ===

-- justinmk/vim-sneak
map({"n", "x", "o"}, ",", "<Plug>Sneak_;")
map({"n", "x", "o"}, ";", "<Plug>Sneak_,")
map({"n", "x", "o"}, "f", "<Plug>Sneak_f")
map({"n", "x", "o"}, "F", "<Plug>Sneak_F")
map({"n", "x", "o"}, "t", "<Plug>Sneak_t")
map({"n", "x", "o"}, "T", "<Plug>Sneak_T")

-- inkarkat/vim-ReplaceWithRegister
-- Todo: Match visual mode p and P with this
--       Add variant d<leader>p
--       One should add deletion to "", the other should not
map("n", "dp", "<Plug>ReplaceWithRegisterOperator")
map("n", "dpp", "<Plug>ReplaceWithRegisterLine")
map("n", "dP", "dp$", r)

-- tommcdo/vim-exchange
map("n", "cX", "cx$", r)
map("n", "c<C-x>", "0cx$", r) -- Not dot-repeatable... but that would be extremely niche

-- mbbill/undotree
map("n", "<leader>u", ":UndotreeToggle<cr>", s)

-- lambdalisue/fern.vim
map("n", "<leader>-", ":Fern %:h -drawer -reveal=%<cr>", s)
map("n", "<leader>_", ":Fern %:h -reveal=%", s)

-- jpalardy/vim-slime
map("x", "§", "<Plug>SlimeRegionSend")
map("n", "§", "<Plug>SlimeMotionSend")
map("n", "½", "§$", r)
map("n", "§§", "<Plug>SlimeLineSend")
map("n", "<leader>§", "<Plug>SlimeConfig")
