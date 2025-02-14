-- shorthands
local o, g, opt = vim.o, vim.g, vim.opt
local autocmd = vim.api.nvim_create_autocmd

-- Should this be on or no?
-- https://github.com/neovim/neovim/commit/2257ade3dc2daab5ee12d27807c0b3bcf103cd29
vim.loader.enable()

vim.cmd.colorscheme("goodnight")
require("keymaps")

-- Disable autowraps and comment continuations,
-- and prevent /usr/share/nvim/runtime/ftplugins overriding them
autocmd({"FileType"}, {
    callback = function()
        if vim.bo.filetype  ~= "gitcommit" then
            opt.formatoptions:remove({"t", "f", "c", "r", "o"})
        end
    end
})

opt.shortmess:prepend("Ia")
opt.fillchars:prepend("eob:󰧟")

o.clipboard = "unnamedplus"
o.guicursor = "a:block"
o.mouse = ""

o.laststatus = 1
o.statusline = "%t %r%m"

o.timeout = false
o.showcmd = false
o.ruler = false
o.number = true

opt.scrolloff = 6

o.textwidth = 80
o.wrap = false

o.undofile = true
o.confirm = true
o.swapfile = false

-- Search and substitute
o.ignorecase = true -- Warning: unwanted in :substitute, but can be disabled with I flag
o.smartcase = true
o.gdefault = true -- substitute g is on by default - adding g will instead toggle it off

-- :vsplit and :split
o.splitright = true
o.splitbelow = true

-- Indent settings for new files (otherwise guessed by 'indent-o-matic')
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true

-- Globals for plugins
g.lion_prompt = "Pattern: "
g.lion_squeeze_spaces = 1

g["sneak#s_next"] = true     -- f/t/s repeat same key to go forward
g["sneak#use_ic_scs"] = true -- f/t/s ignorecase and smartcase

g.undotree_SetFocusWhenToggle = 1
g.undotree_HighlightChangedWithSign = 0
g.undotree_ShortIndicators = 1
g.undotree_HelpLine = 0

g.miniindentscope_disable = true -- Only care about the textobjects and motions (no visuals)

g.vimtex_syntax_enabled = 0         -- Let latex be handled by treesitter parser
g.vimtex_syntax_conceal_disable = 1

-- Setups
require("Comment").setup()
require("mini.indentscope").setup({
    options = { indent_at_cursor = false }
})
local splitjoin = require("mini.splitjoin")
splitjoin.setup({
    join = {
        hooks_post = {
            splitjoin.gen_hook.pad_brackets({ brackets = { '%b{}' } })
        }
    }
})
require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        disable = {
            "diff" -- doesn't work in undotree
        },
    },
})
-- Use bash parser for filetype PKGBUILD
vim.treesitter.language.register("bash", "PKGBUILD")

-- Disable builtin plugins
g.loaded_netrwPlugin = 0
-- g.loaded_matchparen = 0 -- Disabling matchparen breaks vim-sneak highlight, see:
                           -- https://github.com/justinmk/vim-sneak/issues/305

-- Where plugins?
-- See ./lua/update/plugins.lua
-- Plugins are only updated with a bash script
