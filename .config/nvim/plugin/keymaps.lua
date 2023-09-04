-- shorthands
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

-- <leader> is <Space>
vim.g.mapleader = " "

-- Disable keys that:
--   1. can interfere with other settings
--   2. I want to repurpose later
--   3. are annoying
map("n", "<Up>", "<Nop>")
map("n", "<Down>", "<Nop>")
map("n", "<C-h>", "<Nop>")
map("n", "<C-l>", "<Nop>")
map({"n", "v"}, "<BS>", "<Nop>")
map({"n", "v", "i", "c"}, "<PageUp>", "<Nop>")
map({"n", "v", "i", "c"}, "<PageDown>", "<Nop>")
map({"n", "i"}, "<F1>", "<Nop>")

-- Prevent accidental invokings of macros
map({"n", "v"}, "Q", "q")
map({"n", "v"}, "q", "<Nop>")

-- The default Q is not bad but its default mapping is bad, here's a better alternative:
map("n", "<leader>@", "Q")

-- Tab to search because / sucks in Finnish layout
-- Side effect: Ctrl+i is understood as Tab in terminals, so "go forward in jump list" breaks
-- Map that to Ctrl+p which is free
-- NOTE: NeoVim can differentiate between these, but alacritty can't , see:
-- https://github.com/alacritty/alacritty/issues/3101
map("n", "<Tab>", "/")
map("n", "<S-Tab>", "?")
map("n", "<C-p>", "<C-i>")

-- Start a substitute command without finger gymnastics:
map("n", "<leader><Tab>", ":%s/")

-- Experimental:
map("n", "<C-d>", "0D")
map("n", "å", "o<Esc>")
map("n", "Å", "O<Esc>")
map("n", "<Left>", function() vim.cmd("bprevious") end)
map("n", "<Right>", function() vim.cmd("bnext") end)

local function echo_fullpath_with_tilde()
    vim.cmd("echo substitute(expand('%:p'), $HOME, '~', '')")
end

map("n", "<leader><Enter>", echo_fullpath_with_tilde)
map("n", "<Enter>", function() vim.cmd("echo ''") end) -- clear cmdline text

-- Can't do the above mapping for command line <C-f> special buffer
autocmd({"CmdWinEnter"}, {
    callback = function()
        map("n", "<Enter>", "<Enter>", { buffer=0 })
    end
})

-- Insert/command mode Ctrl+a for beginning of line, Ctrl+E for end of line (readline style)
-- If they override something, remap that elsewhere
map({"i", "c"}, "<C-a>", "<Home>")
map("i", "<C-e>", "<End>")
map({"i", "c"}, "<C-b>", "<C-a>") -- command mode: <C-b> == <Home>, insert mode: <C-b> is unmapped
map("i", "<M-i>", "<C-e>")

-- Comfortable movement keys:
map({"n", "v", "o"}, "<C-j>", "<C-d>")
map({"n", "v", "o"}, "<C-k>", "<C-u>")
map({"n", "v", "o"}, "H", "^")
map({"n", "v", "o"}, "J", "}")
map({"n", "v", "o"}, "K", "{")
map({"n", "v", "o"}, "L", "$")
map("i", "<C-h>", "<Left>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-l>", "<Right>")

-- Remap what the above has overriden
map({"n", "v"}, "¤", "J")
map({"n", "v"}, "g¤", "gJ")
map({"i", "c"}, "<C-z>", "<C-k>")
map("n", "g/", "K")

-- Scroll window but keep cursor where it is
map("n", "<M-h>", "zh")
map("n", "<M-j>", "<C-e>")
map("n", "<M-k>", "<C-y>")
map("n", "<M-l>", "zl")

-- One-handed save and quit
map("n", "<C-s>", function() vim.cmd("w") end)
map("n", "<C-q>", function() vim.cmd("q") end)
map("i", "<C-s>", "<C-o>:w<cr>")
map("i", "<C-q>", "<C-o>:q<cr>")

-- System clipboard easy:
map({"n", "v"}, "<leader>y", '"+y', {remap=true})
map({"n", "v"}, "<leader>p", '"+p', {remap=true})
map({"n", "v"}, "<leader>d", '"+d', {remap=true})
map({"n", "v"}, "<leader>c", '"+c', {remap=true})
map({"n", "v"}, "<leader>s", '"+s', {remap=true}) -- s: recursive from plugin
map("n", "<leader>Y", '"+Y', {remap=true})
map("n", "<leader>P", '"+P', {remap=true})
map("n", "<leader>D", '"+D', {remap=true})
map("n", "<leader>C", '"+C', {remap=true})
map("n", "<leader>S", '"+S', {remap=true}) -- S: recursive from plugin

-- See highlight group under cursor
map("n", "<leader>e", function() vim.cmd("Inspect") end)

-- Mappings to Lua modules
local tws = require("trailingwhitespace")
map("n", "ö", tws.toggle_trailing_whitespace)

-- === PLUGINS ===

-- inkarkat/vim-ReplaceWithRegister
-- Overwrite default s:
map("n", "s", "<Plug>ReplaceWithRegisterOperator", {remap=true})
map("n", "ss", "<Plug>ReplaceWithRegisterLine", {remap=true})
map("v", "s", "<Plug>ReplaceWithRegisterVisual", {remap=true})
map("n", "S", "s$", {remap=true})

-- mbbill/undotree
map("n", "<leader>u", function() vim.cmd("UndotreeToggle") end)

-- lambdalisue/fern.vim
map("n", "<leader>-", function() vim.cmd("Fern %:h -drawer -reveal=%") end)
map("n", "<leader>_", function() vim.cmd("Fern %:h -reveal=%") end)

-- jpalardy/vim-slime
map("v", "§", "<Plug>SlimeRegionSend", {remap=true})
map("n", "§", "<Plug>SlimeMotionSend", {remap=true})
map("n", "½", "§$", {remap=true})
map("n", "§§", "<Plug>SlimeLineSend", {remap=true})
map("n", "<leader>§", "<Plug>SlimeConfig", {remap=true})

-- NOTES:
--      Why do you write
--          function() vim.cmd("vimscript") end
--      instead of
--          ":vimscript<cr>"
--      ?
--
--      - Because that way the command text won't linger in the cmdline
--
--      Isn't there a better/cleaner way?
--      - I don't know.. yet
