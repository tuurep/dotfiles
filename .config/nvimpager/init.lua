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

-- Remap macros
map({"n", "x"}, "q", "<Nop>")
map({"n", "x"}, "Q", "<Nop>")
map({"n", "x"}, "+", "q")
map({"n", "x"}, "<leader>+", "Q")
map({"n", "x"}, "<M-+", "@")

-- Tab to search
map({"n", "x", "o"}, "<Tab>", "/")
map({"n", "x", "o"}, "<S-Tab>", "?")

-- Remap jumplist maps: <C-i> and <Tab> are the same due to terminal weirdness
map("n", "<M-n>", "<C-o>")
map("n", "<M-S-n>", "<C-i>")

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
map({"c"}, "<C-a>", "<Home>")
map({"c"}, "<C-b>", "<C-a>") -- command mode: <C-b> == <Home>, insert mode: <C-b> is unmapped

-- Command mode home row traversal alternatives
map("c", "<M-j>", "<Down>")
map("c", "<M-k>", "<Up>")
map("c", "<M-h>", "<C-Left>")
map("c", "<M-l>", "<C-Right>")

-- Essential keys for both movement and operator pending
-- (with the worst defaults known to man)
map({"n", "x", "o"}, "-", "}")
map({"n", "x", "o"}, "_", "{")
map({"n", "x", "o"}, "H", "^")
map({"n", "x", "o"}, "L", "$")
map({"n", "x", "o"}, "gH", "g^")
map({"n", "x", "o"}, "gL", "g$")

-- Remap what the above has overriden
map({"n", "x", "o"}, "<leader>k", "H")
map({"n", "x", "o"}, "<leader>m", "M")
map({"n", "x", "o"}, "<leader>j", "L")
map({"n", "x"}, "?", "K")

-- Group together similar mappings that move the view without moving the cursor
map({"n", "x"}, "<M-j>", "3<C-e>")
map({"n", "x"}, "<M-k>", "3<C-y>")
map({"n", "x"}, "<M-S-j>", "<C-e>")
map({"n", "x"}, "<M-S-k>", "<C-y>")
map({"n", "x"}, "<M-h>", "3zh")
map({"n", "x"}, "<M-l>", "3zl")
map({"n", "x"}, "<M-S-h>", "zh")
map({"n", "x"}, "<M-S-l>", "zl")
map({"n", "x"}, "zj", "zt")
map({"n", "x"}, "zk", "zb")

-- Swap what was overriden above
map({"n", "x"}, "zt", "zk")
map({"n", "x"}, "zb", "zj")

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
local gen_spec = require('mini.ai').gen_spec
require("mini.ai").setup({
    custom_textobjects = {

        -- Remap 'argument' textobject
        ["v"] = gen_spec.argument(),

        -- Anybracket equivalent for e.g. i(
        ["B"] = { { "%b()", "%b[]", "%b{}" }, "^.%s*().-()%s*.$" },

        -- Brackets aliases
        ["e"] = { "%b()", "^.().*().$" },
        ["d"] = { "%b{}", "^.().*().$" },
        ["a"] = { "%b[]", "^.().*().$" },
        ["<"] = { "%b<>", "^.().*().$" },
        ["E"] = { "%b()", "^.%s*().-()%s*.$" },
        ["D"] = { "%b{}", "^.%s*().-()%s*.$" },
        ["A"] = { "%b[]", "^.%s*().-()%s*.$" },
        [">"] = { "%b<>", "^.%s*().-()%s*.$" },

        -- Quotation aliases (experimental)
        ["r"] = { "%b''", "^.().*().$" },
        ["x"] = { "%b``", "^.().*().$" },
        ["Q"] = { '"""().-()"""' },
        ["X"] = { "```().-()```" },

        -- Markdown (experimental)
        ["m"] = gen_spec.pair("*", "*", { type = "greedy" }),
        ["*"] = gen_spec.pair("*", "*", { type = "greedy" }),
        ["_"] = gen_spec.pair("_", "_", { type = "greedy" }),
        ["M"] = { "%*%*().-()%*%*" },

    },
    silent = true
})

-- mini.indentscope
require("mini.indentscope").setup({
    options = { indent_at_cursor = false }
})
g.miniindentscope_disable = true
map({"n", "x", "o"}, "<leader>i", "]i", r) -- to current indentation level bottom edge
map({"n", "x", "o"}, "<leader>I", "[i", r) -- to current indentation level top edge

-- vim-sneak
g["sneak#s_next"] = true
g["sneak#use_ic_scs"] = true
map({"n", "x", "o"}, "f", "<Plug>Sneak_f")
map({"n", "x", "o"}, "F", "<Plug>Sneak_F")
map({"n", "x", "o"}, "t", "<Plug>Sneak_t")
map({"n", "x", "o"}, "T", "<Plug>Sneak_T")
map({"n", "x", "o"}, ",", "<Plug>Sneak_;")
map({"n", "x", "o"}, ";", "<Plug>Sneak_,")
map({"x", "o"}, "s", "<Plug>Sneak_s")
map({"x", "o"}, "S", "<Plug>Sneak_S")

-- vim-edgemotion
map({"n", "x", "o"}, "J", "<Plug>(edgemotion-j)")
map({"n", "x", "o"}, "K", "<Plug>(edgemotion-k)")
