-- init.lua for nvimpager
-- https://github.com/lucc/nvimpager

-- To use neovim as a pager, we can ignore any editing-related configuration

-- shorthands
local o, g, opt = vim.o, vim.g, vim.opt
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local r = { remap = true }

-- SETTINGS

autocmd("VimEnter", {
    callback = function()
        vim.cmd("normal! L") -- Put cursor on the last line of the first page
    end,
})

vim.loader.enable()

-- Leech plugins from nvim (paq)
opt.runtimepath:append("~/.local/share/nvim/site/pack/paqs/start/vim-sneak")
opt.runtimepath:append("~/.local/share/nvim/site/pack/paqs/start/vim-edgemotion")
opt.runtimepath:append("~/.local/share/nvim/site/pack/paqs/start/nvim-various-textobjs")
opt.runtimepath:append("~/.local/share/nvim/site/pack/paqs/start/mini.ai")

g.loaded_netrwPlugin = 0 -- When unloading netrw, `nvimpager <dir>` shows a blank buffer in pager mode

vim.cmd.colorscheme("goodnight-pager")

opt.shortmess:prepend("Ia")
opt.fillchars:prepend("eob:󰧟")

o.clipboard = "unnamedplus"
o.guicursor = "a:block"
o.mousescroll = "ver:1,hor:1"

o.laststatus = 1
o.statusline = "%t %r%m"

o.cursorline = true -- Only for the LineNr highlight

o.timeout = false
o.showcmd = false
o.ruler = false

o.ignorecase = true
o.smartcase = true

o.splitright = true
o.splitbelow = true

-- KEYMAPS

-- Disable nvimpager default keymaps
nvimpager.maps = false

map({"n", "x", "o"}, "<Space>", "<Nop>")
g.mapleader = " "

-- Pager specifics:
map({"n", "x"}, "§", "<cmd>set number!<cr>")
map({"n", "x"}, "<leader>§", "<cmd>set wrap!<cr>")
map({"n", "x"}, "q", "<cmd>q<cr>")

-- One-handed save
map({"n", "x"}, "<C-q>", "<cmd>q<cr>")

-- Remap macros
map({"n", "x"}, "Q", "q")
map("n", "<leader>@", "Q")

-- Tab to search
map({"n", "x", "o"}, "<Tab>", "/")
map({"n", "x", "o"}, "<S-Tab>", "?")

-- Remap jumplist maps: <C-i> and <Tab> are the same due to terminal weirdness
map("n", "<M-o>", "<C-o>")
map("n", "<M-i>", "<C-i>")

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

-- Remap what the above has overriden
map({"n", "x", "o"}, "_", "H")     -- underscore
map({"n", "x", "o"}, "-", "M")     -- dash
map({"n", "x", "o"}, "<M-->", "L") -- Alt + dash
map({"n", "x"}, "?", "K")

-- Like yy but no newline at end
map("n", "<C-y>", function()
    vim.fn.setreg(vim.v.register, vim.api.nvim_get_current_line())
end)

-- Without shift = forward, with shift = backward
map({"n", "x", "o"}, ",", ";")
map({"n", "x", "o"}, ";", ",")

-- Undo follows the same idea as above
-- Map <M-u> to WeirdUndo so it's still available when you want to use it (never)
map("n", "U", "<C-r>")
map("n", "<M-u>", "U")

-- Brackets aliases
map({"x", "o"}, "ie", "i)", r)
map({"x", "o"}, "iE", "i(", r)
map({"x", "o"}, "ae", "a)", r)
map({"x", "o"}, "aE", "a(", r)

map({"x", "o"}, "ile", "il)", r)
map({"x", "o"}, "ilE", "il(", r)
map({"x", "o"}, "ale", "al)", r)
map({"x", "o"}, "alE", "al(", r)

map({"x", "o"}, "ine", "in)", r)
map({"x", "o"}, "inE", "in(", r)
map({"x", "o"}, "ane", "an)", r)
map({"x", "o"}, "anE", "an{", r)

map({"x", "o"}, "ic", "i}", r)
map({"x", "o"}, "iC", "i{", r)
map({"x", "o"}, "ac", "a}", r)
map({"x", "o"}, "aC", "a{", r)

map({"x", "o"}, "ilc", "il}", r)
map({"x", "o"}, "ilC", "il{", r)
map({"x", "o"}, "alc", "al}", r)
map({"x", "o"}, "alC", "al}", r)

map({"x", "o"}, "inc", "in}", r)
map({"x", "o"}, "inC", "in{", r)
map({"x", "o"}, "anc", "an}", r)
map({"x", "o"}, "anC", "an{", r)

map({"x", "o"}, "ir", "i]", r)
map({"x", "o"}, "iR", "i[", r)
map({"x", "o"}, "ar", "a]", r)
map({"x", "o"}, "aR", "a[", r)

map({"x", "o"}, "ilr", "il]", r)
map({"x", "o"}, "ilR", "il[", r)
map({"x", "o"}, "alr", "al]", r)
map({"x", "o"}, "alR", "al[", r)

map({"x", "o"}, "inr", "in]", r)
map({"x", "o"}, "inR", "in[", r)
map({"x", "o"}, "anr", "an]", r)
map({"x", "o"}, "anR", "an[", r)

-- Todo: swap these mappings without creating a recursive mapping
-- map({"x", "o"}, "i<", "i>", r)
-- map({"x", "o"}, "i>", "i<", r)
-- map({"x", "o"}, "a<", "a>", r)
-- map({"x", "o"}, "a>", "a<", r)
--
-- map({"x", "o"}, "il<", "il>", r)
-- map({"x", "o"}, "il>", "il<", r)
-- map({"x", "o"}, "al<", "al>", r)
-- map({"x", "o"}, "al>", "al<", r)
--
-- map({"x", "o"}, "in<", "in>", r)
-- map({"x", "o"}, "in>", "in<", r)
-- map({"x", "o"}, "an<", "an>", r)
-- map({"x", "o"}, "an>", "an<", r)

-- Treesitter tools
map("n", "<leader>e", "<cmd>Inspect<cr>")
map("n", "<leader>E", "<cmd>InspectTree<cr>")

-- ===== PLUGINS =====

-- nvim-various-textobjs
require("various-textobjs").setup({
    notify = { whenObjectNotFound = false }
})
map(
    {"x", "o"}, "ii",
    "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<cr>"
)
map(
    {"x", "o"}, "ai",
    "<cmd>lua require('various-textobjs').indentation('outer', 'outer')<cr>"
)

-- mini.ai (experimental)
require("mini.ai").setup({silent=true})
map({"n", "x", "o"}, "<leader>q", "g]q", r) -- to next closing anyquote
map({"n", "x", "o"}, "<leader>b", "g]b", r) -- to next closing anybracket

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
