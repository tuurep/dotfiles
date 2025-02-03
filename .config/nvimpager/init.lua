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
opt.runtimepath:append("~/.local/share/nvim/site/pack/paqs/start/mini.ai")
opt.runtimepath:append("~/.local/share/nvim/site/pack/paqs/start/mini.indentscope")

g.loaded_netrwPlugin = 0 -- When unloading netrw, `nvimpager <dir>` shows a blank buffer in pager mode

vim.cmd.colorscheme("goodnight-pager")

opt.shortmess:prepend("Ia")
opt.fillchars:prepend("eob:󰧟")

o.clipboard = "unnamedplus"
o.guicursor = "a:block"
o.mouse = ""

o.laststatus = 1
o.statusline = "%t %r%m"

o.cursorline = true -- Only for the LineNr highlight

o.timeout = false
o.showcmd = false
o.ruler = false

o.scroll = 12
o.scrolloff = 6

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

-- One-handed quit
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

-- Remap what the above has overriden
map({"n", "x", "o"}, "_", "H")     -- underscore
map({"n", "x", "o"}, "-", "M")     -- dash
map({"n", "x", "o"}, "<M-->", "L") -- Alt + dash
map({"n", "x"}, "?", "K")

-- Group together similar mappings that move the view without moving the cursor
map({"n", "x"}, "<M-s>", "<C-e>")
map({"n", "x"}, "<M-d>", "<C-y>")
map({"n", "x"}, "<M-a>", "zh")
map({"n", "x"}, "<M-f>", "zl")

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

-- Treesitter tools
map("n", "<leader>e", "<cmd>Inspect<cr>")
map("n", "<leader>E", "<cmd>InspectTree<cr>")

-- ===== PLUGINS =====

-- mini.ai
require("mini.ai").setup({
    custom_textobjects = {

        -- Anybracket equivalent for e.g. i(
        ['B'] = { { '%b()', '%b[]', '%b{}' }, '^.%s*().-()%s*.$' },

        -- Aliases for default brackets
        ['e'] = { '%b()', '^.().*().$' },
        ['E'] = { '%b()', '^.%s*().-()%s*.$' },
        ['r'] = { '%b[]', '^.().*().$' },
        ['R'] = { '%b[]', '^.%s*().-()%s*.$' },
        ['c'] = { '%b{}', '^.().*().$' },
        ['C'] = { '%b{}', '^.%s*().-()%s*.$' },
        ['<'] = { '%b<>', '^.().*().$' },
        ['>'] = { '%b<>', '^.%s*().-()%s*.$' },

    },
    silent = true
})
map({"n", "x", "o"}, "<leader>q", "g]q", r) -- to next closing anyquote
map({"n", "x", "o"}, "<leader>b", "g]b", r) -- to next closing anybracket

-- mini.indentscope
require("mini.indentscope").setup({
    options = {
        indent_at_cursor = false,
        try_as_border = true
    }
})
g.miniindentscope_disable = true
map({"n", "x", "o"}, "<leader>i", "]i", r) -- to current indentation level bottom edge
map({"n", "x", "o"}, "<leader>I", "[i", r) -- to current indentation level top edge

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
