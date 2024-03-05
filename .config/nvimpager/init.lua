-- init.lua for nvimpager
-- https://github.com/lucc/nvimpager

-- To use neovim as a pager, we can ignore any editing-related configuration

-- shorthands
local o, g, opt = vim.o, vim.g, vim.opt
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

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

map({"n", "x"}, "§", "<cmd>set number!<cr>")
map({"n", "x"}, "<leader>§", "<cmd>set wrap!<cr>")

map({"n", "x"}, "q", "<cmd>q<cr>")
map({"n", "x"}, "<C-q>", "<cmd>q<cr>")

map({"n", "x"}, "Q", "q")
map("n", "<leader>@", "Q")

map({"n", "x", "o"}, "<Tab>", "/")
map({"n", "x", "o"}, "<S-Tab>", "?")

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
map({"n", "x", "o"}, "<C-j>", "<C-d>")
map({"n", "x", "o"}, "<C-k>", "<C-u>")
map({"n", "x", "o"}, "H", "^")
map({"n", "x", "o"}, "J", "}")
map({"n", "x", "o"}, "K", "{")
map({"n", "x", "o"}, "L", "$")
map({"n", "x", "o"}, "gH", "g^")
map({"n", "x", "o"}, "gL", "g$")
map({"n", "x"}, "<M-j>", "<C-e>")
map({"n", "x"}, "<M-k>", "<C-y>")
map("n", "<M-h>", "zh")
map("n", "<M-l>", "zl")

map({"n", "x", "o"}, "_", "H")     -- underscore
map({"n", "x", "o"}, "-", "M")     -- dash
map({"n", "x", "o"}, "<M-->", "L") -- Alt + dash
map({"n", "x"}, "?", "K")

map("n", "<C-y>", function()
    vim.fn.setreg(vim.v.register, vim.api.nvim_get_current_line())
end)

map({"n", "x", "o"}, ",", ";")
map({"n", "x", "o"}, ";", ",")

map("n", "U", "<C-r>")
map("n", "<M-u>", "U")

map("o", "ir", "i]")
map("o", "ar", "a]")
map("o", "ia", "i>")
map("o", "aa", "a>")

map("n", "<leader>e", "<cmd>Inspect<cr>")
map("n", "<leader>E", "<cmd>InspectTree<cr>")

map({"n", "x", "o"}, "f", "<Plug>Sneak_f")
map({"n", "x", "o"}, "F", "<Plug>Sneak_F")
map({"n", "x", "o"}, "t", "<Plug>Sneak_t")
map({"n", "x", "o"}, "T", "<Plug>Sneak_T")
map({"n", "x", "o"}, ",", "<Plug>Sneak_;")
map({"n", "x", "o"}, ";", "<Plug>Sneak_,")

map({"n", "x", "o"}, "<leader>j", "<Plug>(edgemotion-j)")
map({"n", "x", "o"}, "<leader>k", "<Plug>(edgemotion-k)")
