-- Shorthands
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local g = vim.g
local r = { remap = true }
local b = { buffer = 0 }

-- <leader> is <Space>
map({"n", "x", "o"}, "<Space>", "<Nop>")
g.mapleader = " "

-- Free keys:
map({"n", "x", "o"}, "<Up>", "<Nop>")
map({"n", "x", "o"}, "<Down>", "<Nop>")
map({"n", "x", "o"}, "<Left>", "<Nop>")
map({"n", "x", "o"}, "<Right>", "<Nop>")
map({"n", "x", "o"}, "+", "<Nop>")
map({"n", "x", "o"}, "M", "<Nop>")      -- H M L -> _ - Alt-
map({"n", "x", "o"}, "/", "<Nop>")      -- Tab/S-Tab as search, ? is now :help
map("n", "<C-r>", "<Nop>")              -- U as redo
map("n", "<C-o>", "<Nop>")              -- <C-i> is compromised so use <M-o> and <M-i>
map("n", "<C-h>", "<Nop>")
map("n", "<C-l>", "<Nop>")
map({"n", "x"}, "<C-e>", "<Nop>")       -- <M-j> and <M-k> are remapped as <C-e> and <C-y>
map({"n", "x"}, "<BS>", "<Nop>")
map({"n", "x"}, "gJ", "<Nop>")          -- g¤ for spaceless join, leave gJ and gK
                                        -- as ideas for vertical movement mappings

-- Free (but bad):
map({"n", "x", "i", "c"}, "<PageUp>", "<Nop>")
map({"n", "x", "i", "c"}, "<PageDown>", "<Nop>")
map({"n", "i"}, "<F1>", "<Nop>")

-- Prevent accidental invokings of macros
map({"n", "x"}, "Q", "q")
map({"n", "x"}, "q", "<Nop>")

-- The default Q is not bad but its default mapping is bad, here's a better alternative:
map("n", "<leader>@", "Q")

-- Tab to search
map({"n", "x", "o"}, "<Tab>", "/")
map({"n", "x", "o"}, "<S-Tab>", "?")

-- Remap jumplist maps: <C-i> and <Tab> are the same due to terminal weirdness
map("n", "<M-o>", "<C-o>")
map("n", "<M-i>", "<C-i>")

-- Start a substitute command without finger gymnastics:
map("n", "<leader><Tab>", ":%s/")

map("n", "<M-Enter>", function()
    local path = vim.fn.expand("%")
    local tildepath = vim.fn.fnamemodify(path, ":p:~")
    if vim.fn.bufname() == "" then
        tildepath = tildepath .. "[No Name]"
    end
    vim.api.nvim_echo({{tildepath}}, false, {})      -- current buffer full path
end)                                                 -- $HOME as ~

map("n", "<leader><Enter>",
    "<cmd>echo fnamemodify(getcwd(), ':p:~')<cr>")    -- pwd but with tilde

map("n", "<Enter>", "<cmd>echo ''<cr>")               -- clear cmdline text

-- Command mode <C-f> special buffer fixes
autocmd({"CmdWinEnter"}, {
    callback = function()
        map("n", "<Enter>", "<Enter>", b) -- The above Enter mapping can't be used here
        map("n", "q", "<cmd>q<cr>", b)
        -- Todo: this window opens too small,
        --       how to make it behave like normal splits: take half of the
        --       available space above?
    end
})

-- Insert/command mode Ctrl+a for beginning of line, Ctrl+E for end of line (readline style)
-- If they override something, remap that elsewhere
map({"i", "c"}, "<C-a>", "<Home>")
map("i", "<C-e>", "<End>")
map({"i", "c"}, "<C-b>", "<C-a>") -- command mode: <C-b> == <Home>, insert mode: <C-b> is unmapped
map("i", "<M-i>", "<C-e>")

-- Command mode home row traversal alternatives
map("c", "<M-j>", "<Down>")
map("c", "<M-k>", "<Up>")
map("c", "<M-h>", "<C-Left>")
map("c", "<M-l>", "<C-Right>")

-- Comfortable movement keys:
map({"n", "x", "o"}, "<C-j>", "<C-d>")
map({"n", "x", "o"}, "<C-k>", "<C-u>")
map({"n", "x", "o"}, "<leader>j", "}")
map({"n", "x", "o"}, "<leader>k", "{")
map({"n", "x", "o"}, "H", "^")
map({"n", "x", "o"}, "L", "$")
map({"n", "x", "o"}, "gH", "g^")
map({"n", "x", "o"}, "gL", "g$")
map({"n", "x"}, "<M-j>", "<C-e>")
map({"n", "x"}, "<M-k>", "<C-y>")
map("n", "<M-h>", "zh")
map("n", "<M-l>", "zl")
map("i", "<C-h>", "<Left>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-l>", "<Right>")
map("n", "<C-h>", "<cmd>bp<cr>")
map("n", "<C-l>", "<cmd>bn<cr>")

-- Remap what the above has overriden
map({"n", "x"}, "¤", "J")
map({"n", "x"}, "g¤", "gJ")
map({"i", "c"}, "<C-z>", "<C-k>")
map({"n", "x", --[["o"]]}, "_", "H") -- https://github.com/echasnovski/mini.nvim/issues/1088
map({"n", "x", "o"}, "-", "M")     -- dash
map({"n", "x", "o"}, "<M-->", "L") -- Alt + dash
map({"n", "x"}, "?", "K")

-- One-handed save and quit
map("n", "<C-s>", "<cmd>w<cr>")
map("n", "<C-q>", "<cmd>q<cr>")

-- Like yy dd cc but no newline at end
map("n", "<C-y>", function()
    vim.fn.setreg(vim.v.register, vim.api.nvim_get_current_line())
end)
map("n", "<C-d>", '<C-y>0"_D', r) -- blackhole the deletion to not set unnamed reg
map("n", "<C-c>", '<C-y>0"_C', r) -- if another reg was chosen

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

-- vim-surround uses targets r for ] and a for >
-- those are great ideas, add these mappings more generally
map("o", "ir", "i]")
map("o", "ar", "a]")
map("o", "ia", "i>")
map("o", "aa", "a>")

-- Treesitter tools
map("n", "<leader>e", "<cmd>Inspect<cr>")
map("n", "<leader>E", "<cmd>InspectTree<cr>")

-- Bigger lua functions
map("n", "Å", require("trailingwhite-toggle"))

-- ===== PLUGINS =====

-- mini.operators
local operators = require("mini.operators")
operators.setup({
    replace  = { prefix = "" },
    exchange = { prefix = "" }
})
operators.make_mappings(
    "replace", { textobject = "dp", line = "dpp", selection = "" } -- in visual, P already does it
)
operators.make_mappings(
    "exchange", { textobject = "cx", line = "cxx", selection = "X" }
)
map("n", "dP", "dp$", r)
map("n", "cX", "cx$", r)
map("n", "gM", "gm$", r)
map("n", "gS", "gs$", r)

-- nvim-various-textobjs
map(
    {"x", "o"}, "ii",
    "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<cr>"
)
map(
    {"x", "o"}, "ai",
    "<cmd>lua require('various-textobjs').indentation('outer', 'outer')<cr>"
)
map(
    {"x", "o"}, "iq",
    "<cmd>lua require('various-textobjs').anyQuote('inner')<cr>"
)
map(
    {"x", "o"}, "aq",
    "<cmd>lua require('various-textobjs').anyQuote('outer')<cr>"
)

-- vim-sneak
map({"n", "x", "o"}, "f", "<Plug>Sneak_f")
map({"n", "x", "o"}, "F", "<Plug>Sneak_F")
map({"n", "x", "o"}, "t", "<Plug>Sneak_t")
map({"n", "x", "o"}, "T", "<Plug>Sneak_T")
map({"n", "x", "o"}, ",", "<Plug>Sneak_;")
map({"n", "x", "o"}, ";", "<Plug>Sneak_,")

-- vim-edgemotion
map({"n", "x", "o"}, "J", "<Plug>(edgemotion-j)")
map({"n", "x", "o"}, "K", "<Plug>(edgemotion-k)")

-- vim-lion
g.lion_map_left = "gh"
g.lion_prompt_map = "<Tab>" -- (added in my fork)

-- undotree
map("n", "<leader>u", "<cmd>UndotreeToggle<cr>", r)

-- undotree buffer default overwrites
g.Undotree_CustomMap = function()
    map("n", "<C-q>", "<Plug>UndotreeClose", b)
    map("n", "U", "<Plug>UndotreeRedo", b)
    map("n", "J", "<Plug>UndotreePreviousSavedState", b) -- Note: PreviousSaved and NextSaved
    map("n", "K", "<Plug>UndotreeNextSavedState", b)     --     seem broken, jumping to
    map("n", "<Tab>", "/", b)                            --     wrong nodes or getting stuck
    map("n", "C", "<Nop>", b)
end

-- vim-dirvish
map("n", "<C-PageUp>", "<Plug>(dirvish_up)") -- Other dirvish maps in ftplugin/dirvish.lua
